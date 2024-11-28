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
