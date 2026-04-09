// Helpers para Angular funcionar offline
(function() {
    'use strict';

    // Prevenir timeouts longos
    const originalSetTimeout = window.setTimeout;
    window.setTimeout = function(callback, delay) {
        // Limitar timeouts muito longos que podem travar a página
        if (delay > 10000) {
            console.log('Mock Helper: Timeout longo reduzido de', delay, 'para 1000ms');
            delay = 1000;
        }
        return originalSetTimeout(callback, delay);
    };

    // Simular que o documento está pronto
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', function() {
            console.log('Mock Helper: DOMContentLoaded simulado');
        });
    }

    // Prevenir loops infinitos
    let timeoutCount = 0;
    const originalSetInterval = window.setInterval;
    window.setInterval = function(callback, delay) {
        timeoutCount++;
        if (timeoutCount > 50) {
            console.warn('Mock Helper: Muitos setInterval detectados, possível loop infinito');
            return -1; // Não executar mais intervals
        }
        return originalSetInterval(callback, Math.max(delay, 100)); // Mínimo 100ms
    };

    // Simular algumas APIs do navegador que podem estar faltando
    if (!window.requestAnimationFrame) {
        window.requestAnimationFrame = function(callback) {
            return setTimeout(callback, 16); // ~60fps
        };
    }

    if (!window.cancelAnimationFrame) {
        window.cancelAnimationFrame = function(id) {
            clearTimeout(id);
        };
    }

    // Prevenir erros de Service Worker
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register = function() {
            return Promise.resolve({
                active: null,
                installing: null,
                waiting: null,
                unregister: function() { return Promise.resolve(true); }
            });
        };
    }

    // Simular WebSocket para conexões em tempo real
    window.MockWebSocket = function(url) {
        this.url = url;
        this.readyState = 1; // OPEN
        this.onopen && this.onopen();
        setTimeout(() => {
            this.onmessage && this.onmessage({ data: JSON.stringify({ type: 'ping' }) });
        }, 1000);
    };

    const originalWebSocket = window.WebSocket;
    window.WebSocket = window.MockWebSocket;

    console.log('Mock Helper: Helpers para Angular carregados');
})();