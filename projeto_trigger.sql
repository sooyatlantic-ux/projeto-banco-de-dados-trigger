-- 1. Criar o banco de dados
CREATE DATABASE SISTEMA_AUDITORIA;
USE SISTEMA_AUDITORIA;

-- 2. Criar a tabela principal de Alunos
CREATE TABLE ALUNOS (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(100)
);

-- 3. Criar a tabela de Log (onde o trigger vai salvar as informações)
CREATE TABLE LOG_AUDITORIA (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    MENSAGEM VARCHAR(255),
    DATA_HORA DATETIME
);

-- 4. Criar o TRIGGER
-- Este trigger dispara DEPOIS (AFTER) de cada inserção na tabela ALUNOS
DELIMITER //

CREATE TRIGGER tr_registro_aluno_novo
AFTER INSERT ON ALUNOS
FOR EACH ROW
BEGIN
    INSERT INTO LOG_AUDITORIA (MENSAGEM, DATA_HORA)
    VALUES (CONCAT('Novo aluno inserido: ', NEW.NOME), NOW());
END; //

DELIMITER ;

-- 5. Testando o comando
-- Insira um aluno e veja a mágica acontecer
INSERT INTO ALUNOS (NOME, EMAIL) VALUES ('Letícia Sanders', 'leticia@exemplo.com');

-- 6. Verifique se o Trigger funcionou consultando a tabela de Log
SELECT * FROM LOG_AUDITORIA;