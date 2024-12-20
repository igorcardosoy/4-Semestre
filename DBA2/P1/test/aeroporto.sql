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

-- Tabela de Passageiros por Voo
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


/*
* Questão 2
*/
-- Passageiros em voos nacionais
SELECT DISTINCT
         p.nome,
         p.cpf,
         p.telefone,
         p.passaporte,
         v.numero_voo,
         origem.nome AS origem,
         destino.nome AS destino
    FROM passageiro p
    NATURAL JOIN passageiro_voo pv
    NATURAL JOIN voo v
    JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
    JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
    WHERE origem.PAIS = 'Brasil' AND destino.PAIS = 'Brasil';

-- Passageiros em voos internacionais
SELECT DISTINCT
         p.nome,
         p.cpf,
         p.telefone,
         p.passaporte,
         v.numero_voo,
         origem.nome AS origem,
         destino.nome AS destino
    FROM passageiro p
      NATURAL JOIN passageiro_voo pv
      NATURAL JOIN voo v
   JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
   JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
   WHERE origem.PAIS != 'Brasil' OR destino.PAIS != 'Brasil';


-- Seleciona os IDs dos passageiros que viajaram em voos nacionais, os que participaram de voos internaccionais e, depois, intersecciona os IDs dos passageiros que aparecem em ambos os conjuntos, ou seja, que viajaram em ambos os tipos de voos. 
SELECT  
    f.nome AS Nome, 
    'Funcionario' AS Tipo, 
    v.numero_voo AS NumeroVoo, 
    v.data_partida AS DataPartida 
FROM  funcionario f 
   JOIN  funcionario_voo fv USING (funcionario_id)
   JOIN   voo v ON fv.voo_id = v.voo_id 
UNION ALL 
   SELECT  
      p.nome AS Nome, 
      'Passageiro' AS Tipo, 
      v.numero_voo AS NumeroVoo, 
      v.data_partida AS DataPartida 
      FROM  passageiro p 
      JOIN  passageiro_voo pv USING (passageiro_id)
      JOIN  voo v ON pv.voo_id = v.voo_id 
ORDER BY  
    DataPartida, Tipo, Nome;

-- Quais aeronaves estão inativas atualmente, listar seu modelo, fabricante e a data da última manutenção realizada, e tiveram voos internacionais no ano de 2024.
SELECT DISTINCT
   a.MODELO, 
   a.FABRICANTE,
   a.STATUS,
   v.DATA_CHEGADA,
   origem.nome AS origem,
   destino.nome AS destino,
   m.DATA_MANUTENCAO
FROM AERONAVE a 
   LEFT JOIN MANUTENCAO m USING (AERONAVE_ID)
   JOIN VOO v USING (AERONAVE_ID)
   JOIN aeroporto origem ON v.ORIGEM_ID = origem.AEROPORTO_ID
   JOIN aeroporto destino ON v.DESTINO_ID = destino.AEROPORTO_ID
WHERE a.STATUS = 'Inativa'
AND (origem.PAIS != 'Brasil' OR destino.PAIS != 'Brasil')
AND v.DATA_PARTIDA   
   BETWEEN TO_DATE('2024-01-01', 'YYYY-MM-DD') 
   AND TO_DATE('2024-12-31', 'YYYY-MM-DD')
ORDER BY m.DATA_MANUTENCAO;

--Identificar os aeroportos brasileiros que permitem voos internacionais que mais serviram como destino de voos no último ano e listar o nome do aeroporto, a cidade e o número total de voos recebidos.

SELECT 
   a.NOME, 
   a.CIDADE, 
   COUNT(v.DESTINO_ID) AS TotalVoos
FROM AEROPORTO a
   JOIN VOO v ON a.AEROPORTO_ID = v.DESTINO_ID
   WHERE a.PAIS = 'Brasil'
   AND a.NOME LIKE '%Internacional%'
GROUP BY a.NOME, a.CIDADE
ORDER BY TotalVoos DESC;

/*
* Questão 3
* Criação de 3 subconsultas, com a explicação do porquê de sua classificação como subconsulta;
*/

SELECT Fabricante, AVG(CustoTotal) AS MediaCusto 
FROM ( 
      SELECT a.FABRICANTE, 
      SUM(m.CUSTO) AS CustoTotal 
      FROM MANUTENCAO m 
      INNER JOIN AERONAVE a USING (AERONAVE_ID)
      GROUP BY a.FABRICANTE 
   ) 
GROUP BY Fabricante;

-- Seleciona o fabricante e o custo médio de manutenção das aeronaves por fabricante, através de uma subconsulta que agrupa e seleciona todas as manutenções realizadas por fabricante. 
SELECT v.numero_voo, ( 
      SELECT COUNT(*)   
      FROM funcionario_voo fv   
      WHERE fv.voo_id = v.voo_id  
    ) AS total_funcionarios  
FROM voo v;

--Seleciona o número do voo e a quantidade de funcionários presentes em cada voo, utilizando uma subconsulta que seleciona e conta cada funcionário presente em cada voo. 
SELECT p.nome, ( 
   SELECT COUNT(*)  
   FROM passageiro_voo pv  
   WHERE pv.passageiro_id = p.passageiro_id 
) AS total_voos 
FROM passageiro p;


-- Inserts para a tabela de Aeronaves
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Boeing 737', 'Boeing', 200, 'Ativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Airbus A320', 'Airbus', 180, 'Inativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Embraer E195', 'Embraer', 132, 'Ativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Boeing 747', 'Boeing', 400, 'Inativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Airbus A380', 'Airbus', 800, 'Ativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('McDonnell Douglas MD-80', 'McDonnell Douglas', 150, 'Inativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Lockheed L-1011 TriStar', 'Lockheed', 300, 'Inativa');
INSERT INTO aeronave (modelo, fabricante, capacidade, status) VALUES ('Concorde', 'Aerospatiale/BAC', 120, 'Inativa');


-- Inserts para a tabela de Passageiros
INSERT INTO passageiro (nome, cpf, telefone, passaporte) VALUES ('João Silva', '12345678901', '11999999999', 'BR123456');
INSERT INTO passageiro (nome, cpf, telefone, passaporte) VALUES ('Maria Oliveira', '23456789012', '11988888888', 'BR234567');
INSERT INTO passageiro (nome, cpf, telefone, passaporte) VALUES ('Carlos Pereira', '34567890123', '11977777777', NULL);
INSERT INTO passageiro (nome, cpf, telefone, passaporte) VALUES ('Ana Costa', '45678901234', '11966666666', 'BR345678');
INSERT INTO passageiro (nome, cpf, telefone, passaporte) VALUES ('Lucas Mendes', '56789012345', '11955555555', NULL);

-- Inserts para a tabela de Funcionários
INSERT INTO funcionario (nome, cpf, cargo, setor) VALUES ('Paulo Andrade', '67890123456', 'Piloto', 'Operações');
INSERT INTO funcionario (nome, cpf, cargo, setor) VALUES ('Fernanda Souza', '78901234567', 'Comissário', 'Operações');
INSERT INTO funcionario (nome, cpf, cargo, setor) VALUES ('Rafael Lima', '89012345678', 'Mecânico', 'Manutenção');
INSERT INTO funcionario (nome, cpf, cargo, setor) VALUES ('Mariana Ribeiro', '90123456789', 'Supervisor', 'Administração');
INSERT INTO funcionario (nome, cpf, cargo, setor) VALUES ('Pedro Santos', '01234567890', 'Mecânico', 'Manutenção');

-- Inserts para a tabela de Aeroportos
INSERT INTO aeroporto (nome, cidade, estado, pais) VALUES ('Aeroporto Internacional de Guarulhos', 'São Paulo', 'SP', 'Brasil');
INSERT INTO aeroporto (nome, cidade, estado, pais) VALUES ('Aeroporto Internacional Tom Jobim', 'Rio de Janeiro', 'RJ', 'Brasil');
INSERT INTO aeroporto (nome, cidade, estado, pais) VALUES ('JFK International Airport', 'Nova York', 'Nova York', 'EUA');
INSERT INTO aeroporto (nome, cidade, estado, pais) VALUES ('Heathrow Airport', 'Londres', 'Inglaterra', 'Reino Unido');
INSERT INTO aeroporto (nome, cidade, estado, pais) VALUES ('Aeroporto Internacional de Brasília', 'Brasília', 'DF', 'Brasil');

-- Inserts para a tabela de Voos
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) VALUES ('GRU123', 1, 2, 1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) VALUES ('GIG456', 2, 1, 3, TO_DATE('2024-07-15', 'YYYY-MM-DD'), TO_DATE('2024-07-15', 'YYYY-MM-DD'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) VALUES ('NYC789', 4, 3, 1, TO_DATE('2024-05-05', 'YYYY-MM-DD'), TO_DATE('2024-05-05', 'YYYY-MM-DD'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) VALUES ('LHR101', 2, 4, 2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), TO_DATE('2024-02-20', 'YYYY-MM-DD'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) VALUES ('BSB202', 3, 5, 2, TO_DATE('2024-06-18', 'YYYY-MM-DD'), TO_DATE('2024-06-18', 'YYYY-MM-DD'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) 
VALUES ('MD101', 4, 3, 2, TO_DATE('2024-10-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-10-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) 
VALUES ('LL202', 5, 5, 4, TO_DATE('2024-09-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-09-15 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status) 
VALUES ('CC303', 6, 4, 1, TO_DATE('2024-08-20 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-08-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

-- Inserts para a tabela de Funcionários por Voo
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario) VALUES (1, 1, 'Piloto');
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario) VALUES (2, 1, 'Comissário');
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario) VALUES (1, 2, 'Piloto');
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario) VALUES (3, 3, 'Mecânico');
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario) VALUES (4, 5, 'Supervisor');

-- Inserts para a tabela de Passageiros por Voo
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo) VALUES (1, 1, '12A', 'Confirmado');
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo) VALUES (2, 1, '12B', 'Confirmado');
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo) VALUES (3, 2, '14C', 'Confirmado');
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo) VALUES (4, 3, '15D', 'Confirmado');
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo) VALUES (5, 4, '16E', 'Confirmado');

-- Inserts para a tabela de Manutenção
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) VALUES (2, 3, TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'Troca de turbinas', 50000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) VALUES (4, 5, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 'Revisão geral', 30000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) VALUES (2, 3, TO_DATE('2024-06-10', 'YYYY-MM-DD'), 'Inspeção de segurança', 20000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) VALUES (4, 5, TO_DATE('2024-08-15', 'YYYY-MM-DD'), 'Troca de pneus', 10000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) VALUES (3, 3, TO_DATE('2024-09-25', 'YYYY-MM-DD'), 'Substituição de bateria', 15000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) 
VALUES (4, 1, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Substituição de componentes hidráulicos', 4500);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) 
VALUES (5, 2, TO_DATE('2024-10-20', 'YYYY-MM-DD'), 'Inspeção completa do sistema elétrico', 7000);
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo) 
VALUES (6, 3, TO_DATE('2024-09-05', 'YYYY-MM-DD'), 'Revisão estrutural e troca de pneus', 6000);
