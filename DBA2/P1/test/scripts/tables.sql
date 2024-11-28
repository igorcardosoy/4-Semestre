-- Run with AEROPORTO user.

DROP TABLE manutencao;
DROP TABLE passageiro_voo;
DROP TABLE funcionario_voo;
DROP TABLE voo;
DROP TABLE aeroporto;
DROP TABLE funcionario;
DROP TABLE passageiro;
DROP TABLE aeronave;

-- Tabela de Aeronaves
CREATE TABLE aeronave (
   aeronave_id   NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   modelo        VARCHAR(100) NOT NULL,
   fabricante    VARCHAR(100) NOT NULL,
   capacidade    NUMBER NOT NULL,
   status        VARCHAR(50) NOT NULL
);


-- Tabela de Passageiros
CREATE TABLE passageiro (
   passageiro_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   nome          VARCHAR(50) NOT NULL,
   cpf           VARCHAR(11) NOT NULL UNIQUE,
   telefone      VARCHAR(15) NOT NULL,
   passaporte    VARCHAR(50)
);


-- Tabela de Funcionários
CREATE TABLE funcionario (
   funcionario_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   nome           VARCHAR(50) NOT NULL,
   cpf            VARCHAR(11) NOT NULL UNIQUE,
   cargo          VARCHAR(50) NOT NULL,
   setor          VARCHAR(50) NOT NULL

);


-- Tabela de Aeroportos
CREATE TABLE aeroporto (
   aeroporto_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   nome         VARCHAR(50) NOT NULL,
   cidade       VARCHAR(50) NOT NULL,
   estado       VARCHAR(50) NOT NULL,
   pais         VARCHAR(50) NOT NULL

);


-- Tabela de Voos
CREATE TABLE voo (
   voo_id        NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   numero_voo    VARCHAR(50) NOT NULL,
   aeronave_id   NUMBER NOT NULL,
   destino_id    NUMBER NOT NULL,
   origem_id     NUMBER NOT NULL,
   data_partida  DATE NOT NULL,
   data_chegada  DATE NOT NULL,
   status        NUMBER NOT NULL,

   CONSTRAINT fk_aeronave FOREIGN KEY (aeronave_id) REFERENCES aeronave (aeronave_id),
   CONSTRAINT fk_destino FOREIGN KEY (destino_id) REFERENCES aeroporto (aeroporto_id),
   CONSTRAINT fk_origem FOREIGN KEY (origem_id) REFERENCES aeroporto (aeroporto_id)

);


-- Tabela de Funcionários por Voo
CREATE TABLE funcionario_voo (
   funcionario_voo_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   funcionario_id     NUMBER NOT NULL,
   voo_id             NUMBER NOT NULL,
   cargo_funcionario  VARCHAR(50) NOT NULL,
   CONSTRAINT fk_funcionario_voo FOREIGN KEY (funcionario_id) REFERENCES funcionario (funcionario_id),
   CONSTRAINT fk_voo FOREIGN KEY (voo_id) REFERENCES voo (voo_id)
);


-- Table de Passageiros por Voo
CREATE TABLE passageiro_voo (
   passageiro_voo_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   passageiro_id     NUMBER NOT NULL,
   voo_id             NUMBER NOT NULL,
   assento           VARCHAR(10) NOT NULL,
   status_voo        VARCHAR(50) NOT NULL,
   
   CONSTRAINT fk_passageiro_voo_passageiro FOREIGN KEY (passageiro_id) REFERENCES passageiro (passageiro_id),
   CONSTRAINT fk_passageiro_voo_voo FOREIGN KEY (voo_id) REFERENCES voo (voo_id)
);

-- Tabela de Manutenção
CREATE TABLE manutencao (
   manutencao_id    NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
   aeronave_id      NUMBER NOT NULL,
   funcionario_id   NUMBER NOT NULL,
   data_manutencao  DATE NOT NULL,
   descricao        VARCHAR(255) NOT NULL,
   custo            NUMBER NOT NULL,
   
   CONSTRAINT fk_aeronave_manutencao FOREIGN KEY (aeronave_id) REFERENCES aeronave (aeronave_id),
   CONSTRAINT fk_funcionario_manutencao FOREIGN KEY (funcionario_id) REFERENCES funcionario (funcionario_id)
);