-- Inserindo Aeronaves
INSERT INTO aeronave (modelo, fabricante, capacidade, status)
VALUES ('Boeing 737', 'Boeing', 180, 'Em operação');

INSERT INTO aeronave (modelo, fabricante, capacidade, status)
VALUES ('Airbus A320', 'Airbus', 150, 'Em operação');

INSERT INTO aeronave (modelo, fabricante, capacidade, status)
VALUES ('Embraer 190', 'Embraer', 100, 'Em operação');

INSERT INTO aeronave (modelo, fabricante, capacidade, status)
VALUES ('Airbus A350', 'Airbus', 250, 'Em manutenção');

INSERT INTO aeronave (modelo, fabricante, capacidade, status)
VALUES ('Boeing 777', 'Boeing', 350, 'Em operação');

-- Inserindo Passageiros
INSERT INTO passageiro (nome, cpf, telefone, passaporte)
VALUES ('João Silva', '12345678901', '1234-5678', 'AB123456');

INSERT INTO passageiro (nome, cpf, telefone, passaporte)
VALUES ('Maria Oliveira', '10987654321', '9876-5432', 'CD987654');

INSERT INTO passageiro (nome, cpf, telefone, passaporte)
VALUES ('Carlos Souza', '11223344556', '2233-4455', 'EF112233');

INSERT INTO passageiro (nome, cpf, telefone, passaporte)
VALUES ('Fernanda Lima', '99887766554', '3344-5566', 'GH998877');

INSERT INTO passageiro (nome, cpf, telefone, passaporte)
VALUES ('Pedro Almeida', '55667788900', '4455-6677', 'IJ556677');

-- Inserindo Funcionários
INSERT INTO funcionario (nome, cpf, cargo, setor)
VALUES ('Carlos Souza', '12345678900', 'Piloto', 'Aéreo');

INSERT INTO funcionario (nome, cpf, cargo, setor)
VALUES ('Fernanda Lima', '98765432100', 'Comissária', 'Aéreo');

INSERT INTO funcionario (nome, cpf, cargo, setor)
VALUES ('Lucas Pereira', '11223344567', 'Coordenador de voo', 'Aéreo');

INSERT INTO funcionario (nome, cpf, cargo, setor)
VALUES ('Juliana Costa', '22334455678', 'Piloto', 'Aéreo');

INSERT INTO funcionario (nome, cpf, cargo, setor)
VALUES ('Ana Beatriz', '33445566789', 'Engenheira de manutenção', 'Manutenção');

-- Inserindo Aeroportos
INSERT INTO aeroporto (nome, cidade, estado, pais)
VALUES ('Aeroporto Internacional de São Paulo', 'São Paulo', 'SP', 'Brasil');

INSERT INTO aeroporto (nome, cidade, estado, pais)
VALUES ('Aeroporto de Galeão', 'Rio de Janeiro', 'RJ', 'Brasil');

INSERT INTO aeroporto (nome, cidade, estado, pais)
VALUES ('Aeroporto de Brasília', 'Brasília', 'DF', 'Brasil');


INSERT INTO aeroporto (nome, cidade, estado, pais)
VALUES ('Aeroporto Internacional de Salvador', 'Salvador', 'BA', 'Brasil');

INSERT INTO aeroporto (nome, cidade, estado, pais)
VALUES ('Aeroporto de Confins', 'Belo Horizonte', 'MG', 'Brasil');

-- Inserindo Voos
INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status)
VALUES ('AA1234', 1, 2, 1, TO_DATE('2024-11-21 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-11-21 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status)
VALUES ('BB5678', 2, 1, 2, TO_DATE('2024-11-21 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-11-21 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status)
VALUES ('CC9012', 3, 3, 4, TO_DATE('2024-11-22 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-11-22 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status)
VALUES ('DD3456', 4, 5, 3, TO_DATE('2024-11-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-11-22 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO voo (numero_voo, aeronave_id, destino_id, origem_id, data_partida, data_chegada, status)
VALUES ('EE7890', 5, 4, 5, TO_DATE('2024-11-23 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-11-23 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

-- Inserindo Funcionários por Voo
INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario)
VALUES (1, 1, 'Piloto');

INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario)
VALUES (2, 1, 'Comissária');

INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario)
VALUES (3, 2, 'Coordenador de voo');

INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario)
VALUES (4, 3, 'Piloto');

INSERT INTO funcionario_voo (funcionario_id, voo_id, cargo_funcionario)
VALUES (5, 4, 'Engenheira de manutenção');

-- Inserindo Passageiros por Voo
INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo)
VALUES (1, 1, '12A', 'Confirmado');

INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo)
VALUES (2, 2, '15B', 'Aguardando');

INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo)
VALUES (3, 3, '10C', 'Confirmado');

INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo)
VALUES (4, 4, '8D', 'Cancelado');

INSERT INTO passageiro_voo (passageiro_id, voo_id, assento, status_voo)
VALUES (5, 5, '5E', 'Confirmado');

-- Inserindo Manutenções
INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo)
VALUES (1, 1, TO_DATE('2024-11-10', 'YYYY-MM-DD'), 'Troca de pneus', 5000);

INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo)
VALUES (2, 2, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'Revisão de motor', 10000);

INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo)
VALUES (3, 3, TO_DATE('2024-11-18', 'YYYY-MM-DD'), 'Inspeção de fuselagem', 7000);

INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo)
VALUES (4, 4, TO_DATE('2024-11-20', 'YYYY-MM-DD'), 'Troca de óleo', 3000);

INSERT INTO manutencao (aeronave_id, funcionario_id, data_manutencao, descricao, custo)
VALUES (5, 5, TO_DATE('2024-11-22', 'YYYY-MM-DD'), 'Calibração de instrumentos', 2000);
