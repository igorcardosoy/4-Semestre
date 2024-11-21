CREATE USER airsystem IDENTIFIED BY airsystem
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;

GRANT CREATE SESSION,
        CREATE TABLE,
        CREATE SEQUENCE,
        CREATE VIEW,
        INSERT ANY TABLE,
        SELECT ANY TABLE,
        UPDATE ANY TABLE,
        DELETE ANY TABLE
TO airsystem;



CREATE TABLE aeronave (
   aeronave_id   NUMBER PRIMARY KEY,
   modelo        VARCHAR2(100) NOT NULL,
   fabricante    VARCHAR2(100) NOT NULL,
   capacidade    NUMBER NOT NULL,
   status        VARCHAR2(50) NOT NULL
);

CREATE TABLE passageiro (
   passageiro_id NUMBER PRIMARY KEY,
   nome          VARCHAR2(50) NOT NULL,
   cpf           CHAR(11) NOT NULL UNIQUE,
   telefone      VARCHAR2(15),
   passaporte    CHAR(8) NOT NULL
);

CREATE TABLE funcionario (
   funcionario_id NUMBER PRIMARY KEY,
   nome           VARCHAR2(50) NOT NULL,
   cpf            CHAR(11) NOT NULL UNIQUE,
   cargo          VARCHAR2(50) NOT NULL,
   setor          VARCHAR2(50) NOT NULL
);

CREATE TABLE aeroporto (
   aeroporto_id NUMBER PRIMARY KEY,
   nome         VARCHAR2(50) NOT NULL,
   cidade       VARCHAR2(50) NOT NULL,
   estado       VARCHAR2(50) NOT NULL,
   pais         VARCHAR2(50) NOT NULL
);

CREATE TABLE voo (
   voo_id       NUMBER PRIMARY KEY,
   numerovoo    VARCHAR2(50) NOT NULL UNIQUE,
   aeronave_id  NUMBER NOT NULL,
   destino_id   NUMBER NOT NULL,
   origem_id    NUMBER NOT NULL,
   datapartida  DATE NOT NULL,
   datachegada  DATE NOT NULL,
   status       NUMBER NOT NULL,
   CONSTRAINT fk_aeronave FOREIGN KEY (aeronave_id)
      REFERENCES aeronave (aeronave_id),
   CONSTRAINT fk_destino FOREIGN KEY (destino_id)
      REFERENCES aeroporto (aeroporto_id),
   CONSTRAINT fk_origem FOREIGN KEY (origem_id)
      REFERENCES aeroporto (aeroporto_id)
);

CREATE TABLE funcionariovoo (
   id              NUMBER PRIMARY KEY,
   funcionario_id  NUMBER NOT NULL,
   voo_id          NUMBER NOT NULL,
   CONSTRAINT fk_funcionario_voo FOREIGN KEY (funcionario_id)
      REFERENCES funcionario (funcionario_id),
   CONSTRAINT fk_voo FOREIGN KEY (voo_id)
      REFERENCES voo (voo_id)
);

CREATE TABLE passageirovoo (
   id             NUMBER PRIMARY KEY,
   passageiro_id  NUMBER NOT NULL,
   aeronave_id    NUMBER NOT NULL,
   assento        VARCHAR2(10) NOT NULL,
   status_voo     VARCHAR2(50) NOT NULL,
   CONSTRAINT fk_passageiro FOREIGN KEY (passageiro_id)
      REFERENCES passageiro (passageiro_id),
   CONSTRAINT fk_aeronave_passageirovoo FOREIGN KEY (aeronave_id)
      REFERENCES aeronave (aeronave_id)
);

CREATE TABLE manutencao (
   aeronave_id     NUMBER NOT NULL,
   funcionario_id  NUMBER NOT NULL,
   datamanutencao  DATE NOT NULL,
   descricao       VARCHAR2(255) NOT NULL,
   custo           NUMBER NOT NULL,
   CONSTRAINT pk_manutencao PRIMARY KEY (aeronave_id, datamanutencao),
   CONSTRAINT fk_aeronave_manutencao FOREIGN KEY (aeronave_id)
      REFERENCES aeronave (aeronave_id),
   CONSTRAINT fk_funcionario_manutencao FOREIGN KEY (funcionario_id)
      REFERENCES funcionario (funcionario_id)
);

-- Inserções otimizadas
INSERT ALL
   INTO aeronave (aeronave_id, modelo, fabricante, capacidade, status) VALUES (1, 'Boeing 737', 'Boeing', 180, 'Ativa')
   INTO aeronave (aeronave_id, modelo, fabricante, capacidade, status) VALUES (2, 'Airbus A320', 'Airbus', 200, 'Manutenção')
   INTO aeronave (aeronave_id, modelo, fabricante, capacidade, status) VALUES (3, 'Embraer E195', 'Embraer', 132, 'Ativa')
SELECT * FROM dual;

INSERT ALL
   INTO passageiro (passageiro_id, nome, cpf, telefone, passaporte) VALUES (1, 'João Silva', '12345678901', '11987654321', 'BR12345')
   INTO passageiro (passageiro_id, nome, cpf, telefone, passaporte) VALUES (2, 'Maria Oliveira', '98765432100', '21976543210', 'BR67890')
   INTO passageiro (passageiro_id, nome, cpf, telefone, passaporte) VALUES (3, 'Carlos Santos', '45678912300', NULL, 'BR54321')
SELECT * FROM dual;

INSERT ALL
   INTO funcionario (funcionario_id, nome, cpf, cargo, setor) VALUES (1, 'Pedro Almeida', '11223344556', 'Piloto', 'Operações')
   INTO funcionario (funcionario_id, nome, cpf, cargo, setor) VALUES (2, 'Ana Costa', '22334455667', 'Comissária', 'Atendimento')
   INTO funcionario (funcionario_id, nome, cpf, cargo, setor) VALUES (3, 'Rafael Lima', '33445566778', 'Mecânico', 'Manutenção')
SELECT * FROM dual;



-- Passageiros em voos nacionais
SELECT DISTINCT
       p.nome,
       p.cpf,
       p.telefone,
       p.passaporte,
       v.numerovoo,
       origem.nome AS origem,
       destino.nome AS destino
  FROM passageiro p
  JOIN passageirovoo pv ON p.id = pv.passageiroid
  JOIN voo v ON pv.aeronaveid = v.aeronaveid
  JOIN aeroporto origem ON v.origemid = origem.id
  JOIN aeroporto destino ON v.destinoid = destino.id
 WHERE origem.pais = 'Brasil' AND destino.pais = 'Brasil';



-- Passageiros em voos internacionais
SELECT DISTINCT
       p.nome,
       p.cpf,
       p.telefone,
       p.passaporte,
       v.numerovoo,
       origem.nome AS origem,
       destino.nome AS destino
  FROM passageiro p
  JOIN passageirovoo pv ON p.id = pv.passageiroid
  JOIN voo v ON pv.aeronaveid = v.aeronaveid
  JOIN aeroporto origem ON v.origemid = origem.id
  JOIN aeroporto destino ON v.destinoid = destino.id
 WHERE origem.pais != 'Brasil' OR destino.pais != 'Brasil';

