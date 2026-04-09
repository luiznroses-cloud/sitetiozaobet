#!/usr/bin/env python
"""Script simplificado para baixar páginas com recursos"""

import sys
import os
from pathlib import Path
from playwright.sync_api import sync_playwright
import requests
from urllib.parse import urljoin, urlparse
import re

def baixar_pagina(url, output_file):
    """Baixa página HTML renderizada"""
    print(f"🌐 Abrindo: {url}")
    
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        page = browser.new_page()
        page.goto(url, wait_until="networkidle")
        page.wait_for_load_state("networkidle", timeout=5000)
        
        html = page.content()
        
        # Tira screenshot
        screenshot_file = output_file.replace(".html", ".png")
        page.screenshot(path=screenshot_file, full_page=True)
        print(f"📸 Screenshot: {screenshot_file}")
        
        browser.close()
        
    return html

def extrair_urls(html, url_base):
    """Extrai URLs de recursos"""
    recursos = set()
    
    # CSS em <link>
    for match in re.finditer(r'href=["\']([^"\']+\.css[^"\']*)["\']', html):
        recursos.add(urljoin(url_base, match.group(1)))
    
    # JS em <script src>
    for match in re.finditer(r'src=["\']([^"\']+\.js[^"\']*)["\']', html):
        recursos.add(urljoin(url_base, match.group(1)))
    
    # Imagens
    for pattern in [r'src=["\']([^"\']+\.(?:png|jpg|jpeg|gif|svg|ico|webp)[^"\']*)["\']',
                    r'href=["\']([^"\']+\.(?:ico)[^"\']*)["\']']:
        for match in re.finditer(pattern, html, re.IGNORECASE):
            url_img = match.group(1)
            if not url_img.startswith('data:'):
                recursos.add(urljoin(url_base, url_img))
    
    return recursos

def baixar_recurso(url, caminho_local, timeout=10):
    """Baixa um arquivo individual"""
    try:
        resp = requests.get(url, timeout=timeout)
        if resp.status_code == 200:
            Path(caminho_local).parent.mkdir(parents=True, exist_ok=True)
            with open(caminho_local, 'wb') as f:
                f.write(resp.content)
            return True
    except Exception as e:
        print(f"  ⚠️ Erro: {url} - {str(e)[:50]}")
    return False

def main():
    if len(sys.argv) < 2:
        print("Uso: python baixar_pagina_v2.py <url> [arquivo.html]")
        sys.exit(1)
    
    url = sys.argv[1]
    output = sys.argv[2] if len(sys.argv) > 2 else "pagina.html"
    recursos_dir = Path(output).parent / "recursos"
    
    # Passo 1: Baixar página
    print(f"\n📥 Baixando página...")
    html = baixar_pagina(url, str(Path(output).parent / output))
    
    # Passo 2: Salvar HTML
    print(f"💾 Salvando HTML: {output}")
    Path(output).parent.mkdir(parents=True, exist_ok=True)
    with open(output, 'w', encoding='utf-8') as f:
        f.write(html)
    print(f"✅ HTML salvo ({len(html):,} bytes)")
    
    # Passo 3: Extrair e baixar recursos
    print(f"\n📦 Baixando recursos...")
    recursos = extrair_urls(html, url)
    print(f"   Encontrados: {len(recursos)} recursos")
    
    url_map = {}
    for i, url_res in enumerate(recursos, 1):
        ext = Path(urlparse(url_res).path).suffix or '.tmp'
        arquivo_local = recursos_dir / f"recurso_{i}{ext}"
        
        if baixar_recurso(url_res, str(arquivo_local)):
            url_map[url_res] = str(arquivo_local)
            print(f"   ✅ [{i}/{len(recursos)}] {Path(url_res).name}")
    
    # Passo 4: Reescrever URLs no HTML
    print(f"\n✏️ Reescrevendo URLs...")
    
    for url_orig, caminho_local in url_map.items():
        caminho_rel = os.path.relpath(caminho_local, Path(output).parent).replace("\\", "/")
        
        # Nome do arquivo para matching
        nome_arquivo = Path(url_orig).name
        
        # Regex mais agressiva para encontrar qualquer referência ao arquivo
        # Procura por padrões como: href=".../arquivo.js", src="...arquivo.js", etc
        
        # Padrão 1: URL completa com aspas
        html = re.sub(
            re.escape(url_orig).replace(r'\.', r'\.'),
            caminho_rel,
            html,
            flags=re.IGNORECASE
        )
        
        # Padrão 2: Apenas o nome do arquivo (último componente do path)
        padrao_nome = re.escape(nome_arquivo)
        html = re.sub(
            f'(["\'])/?[^"\']*{padrao_nome}(["\'])',
            f'\\1{caminho_rel}\\2',
            html,
            flags=re.IGNORECASE
        )
    
    print(f"   Reescritas: {len(url_map)} URLs")
    
    # Salvar HTML corrigido
    with open(output, 'w', encoding='utf-8') as f:
        f.write(html)
    
    print(f"✅ URLs reescritas no HTML")
    print(f"\n🎉 Concluído! Abra {output} no navegador")

if __name__ == "__main__":
    main()
