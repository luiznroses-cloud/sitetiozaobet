// Dados mockados para Angular funcionar offline
(function() {
    'use strict';

    // Simular dados de configuração
    window.APP_CONFIG = {
        apiUrl: '/api',
        version: '1.0.0',
        environment: 'offline'
    };

    // Simular dados de usuário (se necessário)
    window.USER_DATA = {
        loggedIn: false,
        balance: 0,
        currency: 'BRL'
    };

    // Simular dados de jogos/cassino
    window.GAMES_DATA = [
        { id: 1, name: 'Slots', category: 'slots' },
        { id: 2, name: 'Blackjack', category: 'table' },
        { id: 3, name: 'Roulette', category: 'table' }
    ];

    // Prevenir erros de Angular
    window.ng = window.ng || {};

    // Simular algumas funções do Angular que podem estar faltando
    if (typeof window.getAllAngularTestabilities === 'undefined') {
        window.getAllAngularTestabilities = function() {
            return [];
        };
    }

    console.log('Mock Data: Dados simulados carregados para Angular');
})();