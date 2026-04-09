// Mock API para funcionar offline
(function() {
    'use strict';

    // Interceptar XMLHttpRequest
    const originalXHR = window.XMLHttpRequest;
    window.XMLHttpRequest = function() {
        const xhr = new originalXHR();
        const originalOpen = xhr.open;
        const originalSend = xhr.send;

        xhr.open = function(method, url, async, user, password) {
            // Modificar URLs que começam com / para evitar 404
            if (url.startsWith('/')) {
                console.log('Mock API: Interceptando requisição para', url);
                // Retornar dados mockados para URLs conhecidas
                if (url.includes('/ptb') || url.includes('api')) {
                    this.mockResponse = {
                        status: 200,
                        responseText: JSON.stringify({
                            success: true,
                            data: [],
                            message: 'Dados mockados para funcionamento offline'
                        })
                    };
                }
            }
            return originalOpen.apply(this, arguments);
        };

        xhr.send = function(data) {
            if (this.mockResponse) {
                setTimeout(() => {
                    this.readyState = 4;
                    this.status = this.mockResponse.status;
                    this.responseText = this.mockResponse.responseText;
                    this.onreadystatechange && this.onreadystatechange();
                    this.onload && this.onload();
                }, 100);
                return;
            }
            return originalSend.apply(this, arguments);
        };

        return xhr;
    };

    // Interceptar Fetch API
    const originalFetch = window.fetch;
    window.fetch = function(url, options) {
        console.log('Mock API: Interceptando fetch para', url);

        // URLs que começam com / são modificadas
        if (typeof url === 'string' && url.startsWith('/')) {
            return Promise.resolve({
                ok: true,
                status: 200,
                json: () => Promise.resolve({
                    success: true,
                    data: [],
                    message: 'Resposta mockada para funcionamento offline'
                }),
                text: () => Promise.resolve('{}')
            });
        }

        return originalFetch.apply(this, arguments);
    };

    // Prevenir erros de console que podem travar a página
    const originalConsoleError = console.error;
    console.error = function(...args) {
        // Filtrar erros relacionados a rede/API
        const message = args.join(' ');
        if (message.includes('404') ||
            message.includes('network') ||
            message.includes('fetch') ||
            message.includes('XMLHttpRequest')) {
            console.log('Mock API: Erro de rede interceptado:', message);
            return;
        }
        return originalConsoleError.apply(this, args);
    };

    // Simular que a página está pronta
    window.prerenderReady = true;

    // Prevenir verificações de navegador que podem causar problemas
    window.showMessage = function() {
        console.log('Mock API: Verificação de navegador ignorada');
    };

    console.log('Mock API: Sistema offline ativado');
})();