# 📚 Guia Completo: Implementação do Card "Comissões por Nível"

## 📋 Índice
1. [Visão Geral](#visão-geral)
2. [Estrutura HTML](#estrutura-html)
3. [Estilos CSS](#estilos-css)
4. [JavaScript Completo](#javascript-completo)
5. [Integração com API](#integração-com-api)
6. [Sistema de Cache](#sistema-de-cache)
7. [Proteções e Otimizações](#proteções-e-otimizações)
8. [Passo a Passo Completo](#passo-a-passo-completo)
9. [Testes e Validação](#testes-e-validação)
10. [Troubleshooting](#troubleshooting)

---

## 🎯 Visão Geral

Este guia ensina como implementar completamente o card "Comissões por Nível" que exibe:
- **Indicados** por nível (N1, N2, N3)
- **Depósitos** por nível (N1, N2, N3)
- Integração com filtros de período (Hoje, Ontem, Esta Semana, etc.)
- Sistema de cache para performance
- Proteções contra bugs comuns

### Requisitos
- Arquivo `index.php` (ou arquivo principal da página)
- Acesso à API `/hall/api/agent/promote/report/invitedDepositTotals`
- Card de resumo existente (`._prmote-base-card_1dmru_88`)

---

## 📝 Estrutura HTML

### HTML do Card

O card será injetado dinamicamente via JavaScript após o card de resumo. A estrutura HTML é:

```html
<div class="_commission-levels-card_custom">
    <div class="_commission-levels-container_custom">
        <div class="_commission-levels-title_custom">
            Comissões por Nível
        </div>
        
        <!-- Seção de Indicados -->
        <div class="_invited-section_custom">
            <div class="_invited-title_custom">Indicados</div>
            <div class="_invited-grid_custom">
                <div class="_invited-item_custom" data-invited="n1">
                    <span class="_invited-label_custom">N1</span>
                    <span class="_invited-value_custom">0</span>
                </div>
                <div class="_invited-item_custom" data-invited="n2">
                    <span class="_invited-label_custom">N2</span>
                    <span class="_invited-value_custom">0</span>
                </div>
                <div class="_invited-item_custom" data-invited="n3">
                    <span class="_invited-label_custom">N3</span>
                    <span class="_invited-value_custom">0</span>
                </div>
            </div>
        </div>

        <!-- Seção de Depósitos -->
        <div class="_invited-section_custom">
            <div class="_invited-title_custom">Depósitos</div>
            <div class="_invited-grid_custom">
                <div class="_invited-item_custom" data-deposit="n1">
                    <span class="_invited-label_custom">N1</span>
                    <span class="_invited-value_custom">0,00</span>
                </div>
                <div class="_invited-item_custom" data-deposit="n2">
                    <span class="_invited-label_custom">N2</span>
                    <span class="_invited-value_custom">0,00</span>
                </div>
                <div class="_invited-item_custom" data-deposit="n3">
                    <span class="_invited-label_custom">N3</span>
                    <span class="_invited-value_custom">0,00</span>
                </div>
            </div>
        </div>
    </div>
</div>
```

---

## 🎨 Estilos CSS

### CSS Completo

Adicione este CSS no `<style>` do seu arquivo ou em um arquivo CSS separado:

```css
/* Card Principal */
._commission-levels-card_custom {
    margin-top: 0.24rem;
    padding: 0.24rem;
    background-color: var(--skin_background-color, #1a1a1a);
    border-radius: 0.16rem;
}

/* Container Principal */
._commission-levels-container_custom {
    display: flex;
    flex-direction: column;
    gap: 0.24rem;
    padding: 0.24rem;
    background-color: var(--skin_background-color, #1a1a1a);
    border-radius: 0.16rem;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

/* Título */
._commission-levels-title_custom {
    font-size: 0.28rem;
    font-weight: 600;
    color: var(--skin_color, #ffffff);
    margin-bottom: 0.16rem;
    text-align: center;
}

/* Seção (Indicados ou Depósitos) */
._invited-section_custom {
    display: flex;
    flex-direction: column;
    gap: 0.16rem;
    padding: 0.16rem;
    background-color: rgba(255, 255, 255, 0.05);
    border-radius: 0.12rem;
}

/* Título da Seção */
._invited-title_custom {
    font-size: 0.24rem;
    font-weight: 500;
    color: var(--skin_color, #ffffff);
    margin-bottom: 0.08rem;
}

/* Grid de Itens */
._invited-grid_custom {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 0.16rem;
}

/* Item Individual */
._invited-item_custom {
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 0.16rem;
    background-color: rgba(255, 255, 255, 0.03);
    border-radius: 0.08rem;
    border: 1px solid rgba(255, 255, 255, 0.05);
}

/* Label (N1, N2, N3) */
._invited-label_custom {
    font-size: 0.20rem;
    color: var(--skin_color, #ffffff);
    opacity: 0.7;
    margin-bottom: 0.08rem;
}

/* Valor */
._invited-value_custom {
    font-size: 0.24rem;
    font-weight: 600;
    color: var(--skin_accent_1, #ff4444);
    text-align: center;
}

/* Responsivo Mobile */
@media (max-width: 768px) {
    ._commission-levels-container_custom {
        padding: 0.16rem;
    }
    
    ._invited-grid_custom {
        gap: 0.12rem;
    }
    
    ._invited-item_custom {
        padding: 0.12rem;
    }
    
    ._invited-value_custom {
        font-size: 0.22rem;
    }
}
```

---

## 💻 JavaScript Completo

### 1. Variáveis Globais e Configuração Inicial

```javascript
(function() {
    'use strict';
    
    // ============================================
    // VARIÁVEIS GLOBAIS
    // ============================================
    
    // Cache de dados por timeEnum
    let commissionDataCache = {};
    
    // Últimos dados recebidos
    let lastCommissionData = null;
    
    // Controle de requisições em andamento
    let fetchingTimeEnum = null;
    let fetchQueue = [];
    
    // Controle de debounce
    let updateCommissionLevelsDataTimeout = null;
    let isUpdatingCommissionLevels = false;
    let lastUpdateTimeEnum = null;
    
    // Controle de lock global
    let globalUpdateLock = {
        isLocked: false,
        lockTime: 0,
        lockTimeout: null
    };
    
    // Controle de cliques
    let lastTabClickTime = 0;
    let tabClickTimeout = null;
    let lastGlobalClickTime = 0;
    let globalClickTimeout = null;
    
    // Observers
    let valueProtectionObserver = null;
    let valueMaintenanceInterval = null;
    
    // ============================================
    // FUNÇÕES AUXILIARES
    // ============================================
    
    // Formata número (ex: 1234 -> "1.234")
    function formatNumber(num) {
        if (num === null || num === undefined || isNaN(num)) {
            return '0';
        }
        return parseInt(num, 10).toLocaleString('pt-BR');
    }
    
    // Formata moeda (ex: 1234.56 -> "1.234,56")
    function formatCurrency(num) {
        if (num === null || num === undefined || isNaN(num)) {
            return '0,00';
        }
        return parseFloat(num).toLocaleString('pt-BR', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        });
    }
    
    // Obtém timeEnum baseado na aba ativa
    function getTimeEnumFromActiveTab() {
        const tabsContainer = document.querySelector('.ui-tabs_wrap._time-select_3va19_30');
        if (!tabsContainer) {
            return 2; // Default: Hoje
        }
        
        const tabs = tabsContainer.querySelectorAll('.ui-tab');
        if (!tabs || tabs.length === 0) {
            return 2;
        }
        
        const activeIndex = Array.from(tabs).findIndex(function(tab) {
            return tab.classList.contains('ui-tab--active');
        });
        
        if (activeIndex === -1) {
            return 2;
        }
        
        // Mapeamento: 0=Hoje(2), 1=Ontem(1), 2=Esta semana(3), 3=Última semana(4), 4=Este mês(5), 5=Mês passado(6)
        const timeEnumMap = {
            0: 2, // Hoje
            1: 1, // Ontem
            2: 3, // Esta semana
            3: 4, // Última semana
            4: 5, // Este mês
            5: 6  // Mês passado
        };
        
        return timeEnumMap[activeIndex] !== undefined ? timeEnumMap[activeIndex] : 2;
    }
    
    // Obtém dados das comissões (prioriza cache)
    function getCommissionData() {
        const currentTimeEnum = getTimeEnumFromActiveTab();
        
        // PRIORIDADE 1: Cache do timeEnum atual
        if (commissionDataCache[currentTimeEnum]) {
            return {
                invited: commissionDataCache[currentTimeEnum].invited || { n1: 0, n2: 0, n3: 0 },
                deposits: commissionDataCache[currentTimeEnum].deposits || { n1: 0, n2: 0, n3: 0 }
            };
        }
        
        // PRIORIDADE 2: Últimos dados conhecidos
        if (lastCommissionData) {
            return {
                invited: lastCommissionData.invited || { n1: 0, n2: 0, n3: 0 },
                deposits: lastCommissionData.deposits || { n1: 0, n2: 0, n3: 0 }
            };
        }
        
        // PRIORIDADE 3: Dados do PHP (se disponível)
        if (window.COMMISSION_DATA) {
            return window.COMMISSION_DATA;
        }
        
        // PRIORIDADE 4: Valores padrão
        return {
            invited: { n1: 0, n2: 0, n3: 0 },
            deposits: { n1: 0, n2: 0, n3: 0 }
        };
    }
    
    // ============================================
    // SISTEMA DE LOCK GLOBAL
    // ============================================
    
    function acquireUpdateLock(maxWaitMs = 100) {
        if (globalUpdateLock.isLocked) {
            const timeSinceLock = Date.now() - globalUpdateLock.lockTime;
            if (timeSinceLock < maxWaitMs) {
                return false;
            } else {
                releaseUpdateLock(); // Força liberação se travado
            }
        }
        
        globalUpdateLock.isLocked = true;
        globalUpdateLock.lockTime = Date.now();
        
        if (globalUpdateLock.lockTimeout) {
            clearTimeout(globalUpdateLock.lockTimeout);
        }
        globalUpdateLock.lockTimeout = setTimeout(function() {
            releaseUpdateLock();
        }, 5000);
        
        return true;
    }
    
    function releaseUpdateLock() {
        if (globalUpdateLock.lockTimeout) {
            clearTimeout(globalUpdateLock.lockTimeout);
            globalUpdateLock.lockTimeout = null;
        }
        globalUpdateLock.isLocked = false;
        globalUpdateLock.lockTime = 0;
    }
    
    // ============================================
    // CRIAÇÃO DO HTML
    // ============================================
    
    function createCommissionLevelsHTML(data) {
        return `
            <div class="_commission-levels-card_custom">
                <div class="_commission-levels-container_custom">
                    <div class="_commission-levels-title_custom">
                        Comissões por Nível
                    </div>
                    
                    <div class="_invited-section_custom">
                        <div class="_invited-title_custom">Indicados</div>
                        <div class="_invited-grid_custom">
                            <div class="_invited-item_custom" data-invited="n1">
                                <span class="_invited-label_custom">N1</span>
                                <span class="_invited-value_custom">${formatNumber(data.invited.n1)}</span>
                            </div>
                            <div class="_invited-item_custom" data-invited="n2">
                                <span class="_invited-label_custom">N2</span>
                                <span class="_invited-value_custom">${formatNumber(data.invited.n2)}</span>
                            </div>
                            <div class="_invited-item_custom" data-invited="n3">
                                <span class="_invited-label_custom">N3</span>
                                <span class="_invited-value_custom">${formatNumber(data.invited.n3)}</span>
                            </div>
                        </div>
                    </div>

                    <div class="_invited-section_custom">
                        <div class="_invited-title_custom">Depósitos</div>
                        <div class="_invited-grid_custom">
                            <div class="_invited-item_custom" data-deposit="n1">
                                <span class="_invited-label_custom">N1</span>
                                <span class="_invited-value_custom">${formatCurrency((data.deposits && data.deposits.n1) || 0)}</span>
                            </div>
                            <div class="_invited-item_custom" data-deposit="n2">
                                <span class="_invited-label_custom">N2</span>
                                <span class="_invited-value_custom">${formatCurrency((data.deposits && data.deposits.n2) || 0)}</span>
                            </div>
                            <div class="_invited-item_custom" data-deposit="n3">
                                <span class="_invited-label_custom">N3</span>
                                <span class="_invited-value_custom">${formatCurrency((data.deposits && data.deposits.n3) || 0)}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }
    
    // ============================================
    // INJEÇÃO DO CARD
    // ============================================
    
    function injectCommissionLevels() {
        const maxAttempts = 50;
        let attempts = 0;
        
        const tryInject = setInterval(function() {
            attempts++;
            
            const resumoCard = document.querySelector('._prmote-base-card_1dmru_88');
            
            if (resumoCard) {
                clearInterval(tryInject);
                
                // Verifica se já foi injetado
                const existingCard = document.querySelector('._commission-levels-card_custom');
                if (existingCard) {
                    // Se já existe e está atualizando, não faz nada
                    if (isUpdatingCommissionLevels) {
                        return;
                    }
                    
                    // Se já existe, apenas atualiza valores
                    if (lastCommissionData) {
                        updateCommissionValues(lastCommissionData);
                    } else {
                        const timeEnum = getTimeEnumFromActiveTab();
                        fetchInvitedDeposits(timeEnum, true);
                    }
                    return;
                }
                
                // Busca o timeEnum atual ANTES de criar o HTML
                const currentTimeEnum = getTimeEnumFromActiveTab();
                
                // Verifica se há cache para o timeEnum atual
                if (commissionDataCache[currentTimeEnum]) {
                    // Usa cache para criar o HTML imediatamente
                    const commissionData = commissionDataCache[currentTimeEnum];
                    lastCommissionData = commissionData;
                    
                    const levelsHTML = createCommissionLevelsHTML(commissionData);
                    resumoCard.insertAdjacentHTML('afterend', levelsHTML);
                    
                    console.log('✓ Níveis de comissão injetados com dados do cache');
                    
                    // Busca dados atualizados em background
                    setTimeout(function() {
                        fetchInvitedDeposits(currentTimeEnum, false);
                    }, 100);
                } else {
                    // Se não tem cache, usa lastCommissionData como fallback
                    if (lastCommissionData) {
                        const levelsHTML = createCommissionLevelsHTML(lastCommissionData);
                        resumoCard.insertAdjacentHTML('afterend', levelsHTML);
                        console.log('✓ Níveis de comissão injetados com dados temporários');
                        
                        setTimeout(function() {
                            fetchInvitedDeposits(currentTimeEnum, false);
                        }, 100);
                    } else {
                        // Busca PRIMEIRO antes de criar o HTML
                        fetchInvitedDeposits(currentTimeEnum, false).then(function(data) {
                            const commissionData = data || getCommissionData();
                            const stillNoCard = !document.querySelector('._commission-levels-card_custom');
                            
                            if (stillNoCard) {
                                const levelsHTML = createCommissionLevelsHTML(commissionData);
                                resumoCard.insertAdjacentHTML('afterend', levelsHTML);
                                console.log('✓ Níveis de comissão injetados após buscar dados');
                            } else {
                                updateCommissionValues(commissionData);
                            }
                        }).catch(function(err) {
                            console.error('Erro ao buscar dados:', err);
                            const commissionData = getCommissionData();
                            const stillNoCard = !document.querySelector('._commission-levels-card_custom');
                            if (stillNoCard) {
                                const levelsHTML = createCommissionLevelsHTML(commissionData);
                                resumoCard.insertAdjacentHTML('afterend', levelsHTML);
                            }
                        });
                    }
                }
            }
            
            if (attempts >= maxAttempts) {
                clearInterval(tryInject);
                console.warn('⚠ Não foi possível injetar os níveis de comissão');
            }
        }, 100);
    }
    
    // ============================================
    // BUSCA DE DADOS DA API
    // ============================================
    
    function fetchInvitedDeposits(timeEnum = 2, useCache = true) {
        // Se já está buscando, retorna Promise resolvida
        if (fetchingTimeEnum === timeEnum) {
            return Promise.resolve();
        }
        
        // Se tem cache e deve usar, aplica imediatamente
        if (useCache && commissionDataCache[timeEnum]) {
            const cachedData = commissionDataCache[timeEnum];
            lastCommissionData = cachedData;
            
            const card = document.querySelector('._commission-levels-card_custom');
            if (card) {
                updateCommissionValues(cachedData);
            }
            
            return Promise.resolve(cachedData);
        }
        
        // Marca como buscando
        fetchingTimeEnum = timeEnum;
        
        // Retorna Promise
        return new Promise(function(resolve, reject) {
            try {
                fetch('/hall/api/agent/promote/report/invitedDepositTotals', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ timeEnum })
                })
                .then(function(res) { 
                    if (!res.ok) {
                        throw new Error('HTTP ' + res.status);
                    }
                    return res.json(); 
                })
                .then(function(json) {
                    if (json && json.code === 1 && json.data) {
                        const payload = {
                            invited: {
                                n1: parseInt(json.data.n1?.invitedCount || 0, 10),
                                n2: parseInt(json.data.n2?.invitedCount || 0, 10),
                                n3: parseInt(json.data.n3?.invitedCount || 0, 10)
                            },
                            deposits: {
                                n1: parseFloat(String(json.data.n1?.depositTotal || 0).replace(',', '.')),
                                n2: parseFloat(String(json.data.n2?.depositTotal || 0).replace(',', '.')),
                                n3: parseFloat(String(json.data.n3?.depositTotal || 0).replace(',', '.'))
                            }
                        };
                        
                        // Salva no cache
                        commissionDataCache[timeEnum] = payload;
                        lastCommissionData = payload;
                        
                        const card = document.querySelector('._commission-levels-card_custom');
                        if (card) {
                            updateCommissionValues(payload);
                        } else {
                            injectCommissionLevels();
                            setTimeout(function() {
                                updateCommissionValues(payload);
                            }, 500);
                        }
                        
                        fetchingTimeEnum = null;
                        resolve(payload);
                    } else {
                        if (commissionDataCache[timeEnum]) {
                            const cachedData = commissionDataCache[timeEnum];
                            lastCommissionData = cachedData;
                            const card = document.querySelector('._commission-levels-card_custom');
                            if (card) {
                                updateCommissionValues(cachedData);
                            }
                            fetchingTimeEnum = null;
                            resolve(cachedData);
                        } else {
                            fetchingTimeEnum = null;
                            reject(new Error('Resposta inválida e sem cache'));
                        }
                    }
                })
                .catch(function(err) {
                    console.error('Erro ao buscar dados:', err);
                    fetchingTimeEnum = null;
                    
                    if (commissionDataCache[timeEnum]) {
                        const cachedData = commissionDataCache[timeEnum];
                        lastCommissionData = cachedData;
                        const card = document.querySelector('._commission-levels-card_custom');
                        if (card) {
                            updateCommissionValues(cachedData);
                        }
                        resolve(cachedData);
                    } else {
                        reject(err);
                    }
                });
            } catch (e) {
                console.error('Erro inesperado:', e);
                fetchingTimeEnum = null;
                reject(e);
            }
        });
    }
    
    // ============================================
    // ATUALIZAÇÃO DE VALORES
    // ============================================
    
    function updateCommissionValues(data) {
        if (!data || (!data.invited && !data.deposits)) {
            return;
        }
        
        lastCommissionData = data;
        
        function forceApplyValues() {
            const container = document.querySelector('._commission-levels-container_custom');
            if (!container) {
                return false;
            }
            
            const sections = container.querySelectorAll('._invited-section_custom');
            if (sections.length < 2) {
                return false;
            }
            
            const indicadosSection = sections[0];
            const depositosSection = sections[1];
            let updated = false;
            
            function forceUpdateValue(section, levelIndex, value, isCurrency) {
                const items = section.querySelectorAll('._invited-item_custom');
                if (!items || items.length <= levelIndex) {
                    return false;
                }
                
                const item = items[levelIndex];
                if (!item) return false;
                
                const valueElement = item.querySelector('._invited-value_custom');
                if (valueElement) {
                    const formattedValue = isCurrency ? formatCurrency(value) : formatNumber(value);
                    valueElement.textContent = formattedValue;
                    valueElement.innerText = formattedValue;
                    
                    if (valueElement.firstChild) {
                        valueElement.firstChild.textContent = formattedValue;
                    }
                    
                    if (valueElement.setAttribute) {
                        valueElement.setAttribute('data-value', formattedValue);
                    }
                    
                    updated = true;
                    return true;
                }
                return false;
            }
            
            // Atualiza INDICADOS
            if (data.invited && indicadosSection) {
                ['n1', 'n2', 'n3'].forEach(function(level) {
                    if (data.invited[level] !== undefined) {
                        const levelIndex = parseInt(level.replace('n', '')) - 1;
                        forceUpdateValue(indicadosSection, levelIndex, data.invited[level], false);
                    }
                });
            }
            
            // Atualiza DEPÓSITOS
            if (data.deposits && depositosSection) {
                ['n1', 'n2', 'n3'].forEach(function(level) {
                    if (data.deposits[level] !== undefined) {
                        const levelIndex = parseInt(level.replace('n', '')) - 1;
                        forceUpdateValue(depositosSection, levelIndex, data.deposits[level], true);
                    }
                });
            }
            
            return updated;
        }
        
        // Aplica imediatamente
        forceApplyValues();
    }
    
    // ============================================
    // ATUALIZAÇÃO DE DADOS
    // ============================================
    
    function updateCommissionLevelsData() {
        // Verifica lock ANTES de processar
        if (!acquireUpdateLock(200)) {
            if (updateCommissionLevelsDataTimeout) {
                clearTimeout(updateCommissionLevelsDataTimeout);
            }
            updateCommissionLevelsDataTimeout = setTimeout(function() {
                updateCommissionLevelsData();
            }, 300);
            return;
        }
        
        // Limpa timeout anterior (debounce)
        if (updateCommissionLevelsDataTimeout) {
            clearTimeout(updateCommissionLevelsDataTimeout);
        }
        
        // Se já está atualizando, aguarda
        if (isUpdatingCommissionLevels) {
            releaseUpdateLock();
            updateCommissionLevelsDataTimeout = setTimeout(function() {
                updateCommissionLevelsData();
            }, 500);
            return;
        }
        
        const commissionCard = document.querySelector('._commission-levels-card_custom');
        if (!commissionCard) {
            releaseUpdateLock();
            injectCommissionLevels();
            updateCommissionLevelsDataTimeout = setTimeout(function() {
                updateCommissionLevelsData();
            }, 1000);
            return;
        }
        
        const timeEnum = getTimeEnumFromActiveTab();
        
        // Se é o mesmo timeEnum e já tem cache, apenas aplica cache
        if (timeEnum === lastUpdateTimeEnum && commissionDataCache[timeEnum]) {
            const cachedData = commissionDataCache[timeEnum];
            updateCommissionValues(cachedData);
            releaseUpdateLock();
            return;
        }
        
        // Marca como atualizando
        isUpdatingCommissionLevels = true;
        lastUpdateTimeEnum = timeEnum;
        
        // Aplica cache ANTES de buscar novos dados
        if (commissionDataCache[timeEnum]) {
            const cachedData = commissionDataCache[timeEnum];
            updateCommissionValues(cachedData);
        } else if (lastCommissionData) {
            updateCommissionValues(lastCommissionData);
        }
        
        // Busca novos dados da API
        fetchInvitedDeposits(timeEnum, true).finally(function() {
            setTimeout(function() {
                isUpdatingCommissionLevels = false;
                releaseUpdateLock();
            }, 300);
        });
    }
    
    // ============================================
    // OBSERVAÇÃO DE MUDANÇAS NAS ABAS
    // ============================================
    
    function observeTabChanges() {
        const tabsContainer = document.querySelector('.ui-tabs_wrap._time-select_3va19_30');
        if (!tabsContainer) return;
        
        const tabs = tabsContainer.querySelectorAll('.ui-tab');
        if (!tabs || tabs.length === 0) return;
        
        let lastActiveIndex = -1;
        let checkAndUpdateTimeout = null;
        let lastCheckTime = 0;
        
        function checkAndUpdate() {
            if (globalUpdateLock.isLocked) {
                return;
            }
            
            const now = Date.now();
            if (now - lastCheckTime < 400) {
                if (checkAndUpdateTimeout) {
                    clearTimeout(checkAndUpdateTimeout);
                }
                checkAndUpdateTimeout = setTimeout(checkAndUpdate, 400);
                return;
            }
            
            lastCheckTime = now;
            
            const currentTabs = tabsContainer.querySelectorAll('.ui-tab');
            if (!currentTabs || currentTabs.length === 0) return;
            
            const currentActiveIndex = Array.from(currentTabs).findIndex(function(tab) {
                return tab.classList.contains('ui-tab--active');
            });
            
            if (currentActiveIndex !== -1 && currentActiveIndex !== lastActiveIndex) {
                const activeTab = currentTabs[currentActiveIndex];
                const tabText = activeTab ? activeTab.textContent.trim() : '';
                lastActiveIndex = currentActiveIndex;
                
                setTimeout(function() {
                    updateCommissionLevelsData();
                }, 500);
            }
        }
        
        // Observer de mudanças de classe
        const tabObserver = new MutationObserver(function(mutations) {
            mutations.forEach(function(mutation) {
                if (mutation.type === 'attributes' && mutation.attributeName === 'class') {
                    checkAndUpdate();
                }
            });
        });
        
        tabs.forEach(function(tab) {
            tabObserver.observe(tab, {
                attributes: true,
                attributeFilter: ['class']
            });
        });
        
        // Observer do container
        const containerObserver = new MutationObserver(function() {
            checkAndUpdate();
        });
        
        containerObserver.observe(tabsContainer, {
            childList: true,
            subtree: true,
            attributes: true,
            attributeFilter: ['class']
        });
        
        // Listeners de clique direto
        tabs.forEach(function(tab, index) {
            if (tab.hasAttribute('data-commission-listener')) {
                return;
            }
            
            tab.setAttribute('data-commission-listener', 'true');
            
            tab.addEventListener('click', function(e) {
                const now = Date.now();
                const tabText = this.textContent.trim();
                
                if (now - lastTabClickTime < 500) {
                    return;
                }
                
                lastTabClickTime = now;
                
                if (tabClickTimeout) {
                    clearTimeout(tabClickTimeout);
                }
                
                if (globalUpdateLock.isLocked) {
                    tabClickTimeout = setTimeout(function() {
                        updateCommissionLevelsData();
                    }, 500);
                    return;
                }
                
                tabClickTimeout = setTimeout(function() {
                    updateCommissionLevelsData();
                }, 500);
            }, true);
        });
        
        // Verifica inicialmente
        checkAndUpdate();
    }
    
    // ============================================
    // PROTEÇÃO DE VALORES
    // ============================================
    
    function startValueProtection() {
        if (valueProtectionObserver) {
            valueProtectionObserver.disconnect();
        }
        
        let lastReapplyTime = 0;
        let isUpdating = false;
        
        valueProtectionObserver = new MutationObserver(function(mutations) {
            if (globalUpdateLock.isLocked) {
                return;
            }
            
            if (!lastCommissionData || isUpdating) return;
            
            const now = Date.now();
            if (now - lastReapplyTime < 2000) {
                return;
            }
            
            let needsReapply = false;
            let zeroCount = 0;
            
            mutations.forEach(function(mutation) {
                if (mutation.type === 'childList' && mutation.addedNodes.length > 0) {
                    mutation.addedNodes.forEach(function(node) {
                        if (node.nodeType === 1) {
                            if (node.classList && (
                                node.classList.contains('_commission-levels-card_custom') ||
                                node.classList.contains('_commission-levels-container_custom')
                            )) {
                                needsReapply = true;
                                return;
                            }
                            
                            if (node.classList && node.classList.contains('_invited-value_custom')) {
                                const currentValue = node.textContent.trim();
                                if (currentValue === '0' || currentValue === '0,00' || currentValue === '') {
                                    zeroCount++;
                                }
                            }
                        }
                    });
                }
            });
            
            if (needsReapply || zeroCount >= 2) {
                if (globalUpdateLock.isLocked) {
                    return;
                }
                
                lastReapplyTime = now;
                isUpdating = true;
                
                if (acquireUpdateLock(100)) {
                    setTimeout(function() {
                        updateCommissionValues(lastCommissionData);
                        setTimeout(function() {
                            isUpdating = false;
                            releaseUpdateLock();
                        }, 500);
                    }, 300);
                } else {
                    isUpdating = false;
                }
            }
        });
        
        const container = document.querySelector('._commission-levels-container_custom');
        const resumoCard = document.querySelector('._prmote-base-card_1dmru_88');
        
        if (container) {
            valueProtectionObserver.observe(container, {
                childList: true,
                subtree: true,
                characterData: true
            });
            
            if (resumoCard && resumoCard.parentNode) {
                const parentObserver = new MutationObserver(function(mutations) {
                    mutations.forEach(function(mutation) {
                        if (mutation.type === 'childList') {
                            mutation.removedNodes.forEach(function(node) {
                                if (node.nodeType === 1 && node.classList && 
                                    node.classList.contains('_commission-levels-card_custom')) {
                                    if (lastCommissionData) {
                                        setTimeout(function() {
                                            const newCard = document.querySelector('._commission-levels-card_custom');
                                            if (newCard) {
                                                updateCommissionValues(lastCommissionData);
                                            }
                                        }, 500);
                                    }
                                }
                            });
                            
                            mutation.addedNodes.forEach(function(node) {
                                if (node.nodeType === 1 && node.classList && 
                                    node.classList.contains('_commission-levels-card_custom')) {
                                    if (lastCommissionData) {
                                        setTimeout(function() {
                                            updateCommissionValues(lastCommissionData);
                                        }, 300);
                                    }
                                }
                            });
                        }
                    });
                });
                
                parentObserver.observe(resumoCard.parentNode, {
                    childList: true,
                    subtree: false
                });
            }
        } else {
            setTimeout(startValueProtection, 500);
        }
    }
    
    function startValueMaintenance() {
        if (valueMaintenanceInterval) {
            clearInterval(valueMaintenanceInterval);
        }
        
        let lastMaintenanceCheck = 0;
        
        valueMaintenanceInterval = setInterval(function() {
            if (globalUpdateLock.isLocked) {
                return;
            }
            
            if (!lastCommissionData) return;
            
            const now = Date.now();
            if (now - lastMaintenanceCheck < 5000) {
                return;
            }
            lastMaintenanceCheck = now;
            
            const container = document.querySelector('._commission-levels-container_custom');
            if (!container) return;
            
            const sections = container.querySelectorAll('._invited-section_custom');
            if (sections.length < 2) return;
            
            let needsFix = false;
            let fixCount = 0;
            
            // Verifica indicados
            const indicadosItems = sections[0].querySelectorAll('._invited-item_custom');
            indicadosItems.forEach(function(item, index) {
                const valueElement = item.querySelector('._invited-value_custom');
                if (valueElement) {
                    const currentValue = valueElement.textContent.trim();
                    const level = 'n' + (index + 1);
                    const expectedValue = lastCommissionData.invited && lastCommissionData.invited[level] !== undefined 
                        ? String(formatNumber(lastCommissionData.invited[level])) 
                        : null;
                    
                    if (expectedValue && expectedValue !== '0' && expectedValue !== '' && 
                        (currentValue === '0' || currentValue === '')) {
                        needsFix = true;
                        fixCount++;
                    }
                }
            });
            
            // Verifica depósitos
            const depositosItems = sections[1].querySelectorAll('._invited-item_custom');
            depositosItems.forEach(function(item, index) {
                const valueElement = item.querySelector('._invited-value_custom');
                if (valueElement) {
                    const currentValue = valueElement.textContent.trim();
                    const level = 'n' + (index + 1);
                    const expectedValue = lastCommissionData.deposits && lastCommissionData.deposits[level] !== undefined 
                        ? formatCurrency(lastCommissionData.deposits[level]) 
                        : null;
                    
                    if (expectedValue && expectedValue !== '0,00' && expectedValue !== '0' && 
                        (currentValue === '0,00' || currentValue === '0' || currentValue === '')) {
                        needsFix = true;
                        fixCount++;
                    }
                }
            });
            
            if (needsFix && fixCount >= 2) {
                if (globalUpdateLock.isLocked) {
                    return;
                }
                
                if (acquireUpdateLock(100)) {
                    updateCommissionValues(lastCommissionData);
                    setTimeout(function() {
                        releaseUpdateLock();
                    }, 500);
                }
            }
        }, 5000);
    }
    
    // ============================================
    // INICIALIZAÇÃO
    // ============================================
    
    // Inicia quando o DOM estiver pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            injectCommissionLevels();
            setTimeout(observeTabChanges, 500);
        });
    } else {
        injectCommissionLevels();
        setTimeout(observeTabChanges, 500);
    }
    
    // Observa quando as abas são adicionadas ao DOM
    let tabsObserverActive = true;
    const tabsObserver = new MutationObserver(function(mutations) {
        if (!tabsObserverActive) return;
        
        const tabsContainer = document.querySelector('.ui-tabs_wrap._time-select_3va19_30');
        if (tabsContainer) {
            const tabs = tabsContainer.querySelectorAll('.ui-tab');
            if (tabs && tabs.length > 0) {
                observeTabChanges();
                tabsObserverActive = false;
                tabsObserver.disconnect();
            }
        }
    });
    
    if (document.body) {
        tabsObserver.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
    
    // Inicia proteções quando o card for injetado
    setTimeout(function() {
        const card = document.querySelector('._commission-levels-card_custom');
        if (card && !valueProtectionObserver) {
            startValueProtection();
            startValueMaintenance();
        }
    }, 2000);
    
    // Observa mudanças no DOM
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'childList') {
                const resumoCard = document.querySelector('._prmote-base-card_1dmru_88');
                if (resumoCard && !document.querySelector('._commission-levels-card_custom')) {
                    injectCommissionLevels();
                }
            }
        });
    });
    
    if (document.body) {
        observer.observe(document.body, {
            childList: true,
            subtree: true
        });
    }
    
    // Expõe funções globalmente para debug
    window.updateCommissionLevelsData = updateCommissionLevelsData;
    window.getTimeEnumFromActiveTab = getTimeEnumFromActiveTab;
    window.testCommissionUpdate = function(timeEnum) {
        const testEnum = timeEnum || getTimeEnumFromActiveTab();
        const card = document.querySelector('._commission-levels-card_custom');
        if (!card) {
            console.error('Card não encontrado!');
            return;
        }
        fetchInvitedDeposits(testEnum);
    };
    
    console.log('[Comissões por Nível] Sistema inicializado!');
})();
```

---

## 🔗 Integração com API

### Endpoint da API

A API espera uma requisição POST para:
```
/hall/api/agent/promote/report/invitedDepositTotals
```

### Formato da Requisição

```json
{
    "timeEnum": 2
}
```

**Valores de timeEnum:**
- `1` = Ontem
- `2` = Hoje
- `3` = Esta Semana
- `4` = Última Semana
- `5` = Este Mês
- `6` = Mês Passado

### Formato da Resposta Esperada

```json
{
    "code": 1,
    "data": {
        "n1": {
            "invitedCount": 10,
            "depositTotal": 1000.50
        },
        "n2": {
            "invitedCount": 5,
            "depositTotal": 500.25
        },
        "n3": {
            "invitedCount": 2,
            "depositTotal": 200.00
        }
    }
}
```

---

## 💾 Sistema de Cache

### Como Funciona

1. **Primeira Busca:** Quando um filtro é selecionado pela primeira vez, os dados são buscados da API e salvos no cache
2. **Próximas Buscas:** Quando o mesmo filtro é selecionado novamente, os dados são carregados do cache instantaneamente
3. **Atualização em Background:** Mesmo usando cache, o sistema busca dados atualizados em background para manter os dados frescos

### Estrutura do Cache

```javascript
commissionDataCache = {
    1: { // Ontem
        invited: { n1: 10, n2: 5, n3: 2 },
        deposits: { n1: 1000.50, n2: 500.25, n3: 200.00 }
    },
    2: { // Hoje
        invited: { n1: 15, n2: 8, n3: 3 },
        deposits: { n1: 1500.75, n2: 800.50, n3: 300.00 }
    },
    // ... outros períodos
}
```

---

## 🛡️ Proteções e Otimizações

### 1. Sistema de Lock Global
- Previne múltiplas atualizações simultâneas
- Auto-liberação após 5 segundos (proteção contra travamentos)

### 2. Debounce
- Cliques muito próximos são ignorados
- Múltiplas chamadas são agrupadas em uma única execução

### 3. Cache Inteligente
- Valores aparecem instantaneamente do cache
- Busca em background mantém dados atualizados

### 4. Proteção de Valores
- Observers detectam quando valores são zerados incorretamente
- Reaplicação automática de valores corretos

### 5. Tratamento de Erros
- Em caso de erro na API, mantém valores do cache
- Fallback para valores padrão se necessário

---

## 📖 Passo a Passo Completo

### Passo 1: Preparar o Arquivo

1. Abra o arquivo `index.php` (ou arquivo principal)
2. Localize a tag `</body>` (final do arquivo)
3. Antes do `</body>`, adicione um comentário: `<!-- Comissões por Nível -->`

### Passo 2: Adicionar CSS

1. Localize a tag `<style>` ou `<head>`
2. Adicione o CSS completo fornecido acima
3. Ou crie um arquivo `comissoes-nivel.css` e inclua com `<link>`

### Passo 3: Adicionar JavaScript

1. Antes do `</body>`, adicione uma tag `<script>`
2. Cole todo o código JavaScript fornecido acima
3. Feche a tag `</script>`

### Passo 4: Verificar Seletores

1. Verifique se o card de resumo existe: `._prmote-base-card_1dmru_88`
2. Verifique se as abas de filtro existem: `.ui-tabs_wrap._time-select_3va19_30`
3. Se os seletores forem diferentes, ajuste no código JavaScript

### Passo 5: Verificar Endpoint da API

1. Verifique se o endpoint está correto: `/hall/api/agent/promote/report/invitedDepositTotals`
2. Se for diferente, ajuste na função `fetchInvitedDeposits()`

### Passo 6: Testar

1. Abra a página no navegador
2. Abra o console (F12)
3. Verifique se aparece: `[Comissões por Nível] Sistema inicializado!`
4. Clique nos filtros e verifique se o card aparece e atualiza corretamente

---

## 🧪 Testes e Validação

### Teste 1: Injeção do Card
1. Abra a página
2. Verifique se o card aparece após o card de resumo
3. **Esperado:** Card visível com valores iniciais

### Teste 2: Mudança de Filtro
1. Clique em diferentes filtros (Hoje, Ontem, etc.)
2. Verifique se os valores atualizam
3. **Esperado:** Valores atualizam sem zerar

### Teste 3: Cache
1. Clique em um filtro
2. Aguarde a resposta da API
3. Clique em outro filtro
4. Volte para o filtro anterior
5. **Esperado:** Valores aparecem instantaneamente do cache

### Teste 4: Clique Rápido
1. Clique rapidamente entre diferentes filtros
2. Verifique o console para logs de debounce
3. **Esperado:** Apenas uma atualização ocorre, sem múltiplas requisições

### Teste 5: Erro na API
1. Simule um erro na API (desconecte internet ou mude o endpoint)
2. Verifique se os valores são mantidos
3. **Esperado:** Valores do cache são mantidos, não zeram

---

## 🔧 Troubleshooting

### Problema: Card não aparece
**Solução:**
1. Verifique se o card de resumo existe: `._prmote-base-card_1dmru_88`
2. Verifique o console para erros JavaScript
3. Aumente o `maxAttempts` na função `injectCommissionLevels()`

### Problema: Valores zeram ao mudar filtro
**Solução:**
1. Verifique se o sistema de lock está funcionando
2. Verifique se o cache está sendo populado corretamente
3. Verifique os logs no console

### Problema: Múltiplas requisições
**Solução:**
1. Verifique se o debounce está funcionando
2. Aumente o tempo de debounce se necessário
3. Verifique se há múltiplos listeners nas abas

### Problema: API retorna erro
**Solução:**
1. Verifique o endpoint da API
2. Verifique o formato da requisição
3. Verifique se o `timeEnum` está sendo enviado corretamente

### Problema: Valores não atualizam
**Solução:**
1. Verifique se `updateCommissionValues()` está sendo chamada
2. Verifique se os seletores CSS estão corretos
3. Verifique o console para erros

---

## 📌 Notas Finais

1. **Performance:** O sistema usa cache para melhorar a performance e evitar requisições desnecessárias
2. **UX:** Valores aparecem instantaneamente do cache, melhorando a experiência do usuário
3. **Robustez:** Múltiplas proteções garantem que o sistema funcione mesmo em condições adversas
4. **Manutenção:** Código bem estruturado e comentado facilita manutenção futura

---

## 🆘 Suporte

Se encontrar problemas:
1. Verifique o console do navegador (F12)
2. Verifique a aba Network para requisições à API
3. Verifique os logs no console
4. Use as funções de debug expostas globalmente:
   - `window.updateCommissionLevelsData()` - Força atualização
   - `window.testCommissionUpdate(timeEnum)` - Testa com timeEnum específico
   - `window.getTimeEnumFromActiveTab()` - Retorna timeEnum atual

---

**Data de Criação:** 2025-01-27  
**Versão:** 1.0  
**Autor:** Guia de Implementação Completa
