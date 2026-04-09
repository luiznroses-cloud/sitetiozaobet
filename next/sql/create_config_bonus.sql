-- Migration: Adicionar suporte ao modelo de bônus percentual
-- Execute este SQL no seu banco de dados (phpMyAdmin, MySQL, etc.)
-- Data: 2025-03-03

-- Tabela de configuração do tipo de bônus
-- bonus_tipo: 'fixo' = usa tabela cupom (valor fixo por depósito) | 'percentual' = bônus em % em todos os depósitos
CREATE TABLE IF NOT EXISTS config_bonus (
    id INT PRIMARY KEY DEFAULT 1,
    bonus_tipo ENUM('fixo', 'percentual') NOT NULL DEFAULT 'fixo',
    bonus_percentual INT NOT NULL DEFAULT 0,
    bonus_percentual_status TINYINT NOT NULL DEFAULT 0,
    bonus_percentual_nome VARCHAR(100) DEFAULT 'Bônus em %',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CHECK (id = 1)
);

-- Inserir registro padrão (modelo fixo)
INSERT INTO config_bonus (id, bonus_tipo) VALUES (1, 'fixo')
ON DUPLICATE KEY UPDATE id=id;
