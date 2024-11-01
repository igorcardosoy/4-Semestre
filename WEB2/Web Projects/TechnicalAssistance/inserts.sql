INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Av. Paulista', '1000', 'Apt 101', 'Bela Vista', 'São Paulo', 'SP', '01311-000');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Rua dos Bobos', '0', NULL, 'Centro', 'Campinas', 'SP', '13010-000');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Rua da Liberdade', '200', 'Casa 2', 'Liberdade', 'São Paulo', 'SP', '01503-010');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Av. das Nações', '101', 'Bloco A', 'Centro', 'Brasília', 'DF', '70040-000');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Rua Bahia', '300', NULL, 'Jardins', 'Salvador', 'BA', '40050-000');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Av. Atlântica', '50', 'Apto 101', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021-000');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Rua XV de Novembro', '99', NULL, 'Centro', 'Curitiba', 'PR', '80020-310');
INSERT INTO address (street, number, complement, neighborhood, city, state, zipcode)
VALUES ('Rua da Paz', '500', NULL, 'Jardim', 'Recife', 'PE', '50040-000');

INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('João Silva', 'joao.silva@gmail.com', '(11) 99999-9999', '123.456.789-00', 1);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Maria Oliveira', 'maria.oliveira@hotmail.com', '(19) 98888-8888', '234.567.890-01', 2);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Carlos Pereira', 'carlos.pereira@yahoo.com', '(11) 97777-7777', '345.678.901-02', 3);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Ana Souza', 'ana.souza@gmail.com', '(61) 99999-9999', '456.789.012-03', 4);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Lucas Lima', 'lucas.lima@hotmail.com', '(71) 98765-4321', '567.890.123-04', 5);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Fernanda Alves', 'fernanda.alves@gmail.com', '(21) 91234-5678', '678.901.234-05', 6);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Paulo Moreira', 'paulo.moreira@hotmail.com', '(41) 94567-8901', '789.012.345-06', 7);
INSERT INTO customer (name, email, phone, cpf, address_code)
VALUES ('Juliana Costa', 'juliana.costa@gmail.com', '(81) 93456-7890', '890.123.456-07', 8);


INSERT INTO payment_method (name) VALUES ('Cartão de Crédito');
INSERT INTO payment_method (name) VALUES ('Boleto');
INSERT INTO payment_method (name) VALUES ('Transferência Bancária');
INSERT INTO payment_method (name) VALUES ('Dinheiro');
INSERT INTO payment_method (name) VALUES ('PIX');
INSERT INTO payment_method (name) VALUES ('Cartão de Débito');
INSERT INTO payment_method (name) VALUES ('PayPal');
INSERT INTO payment_method (name) VALUES ('Cheque');


INSERT INTO status (name) VALUES ('Aberto');
INSERT INTO status (name) VALUES ('Em andamento');
INSERT INTO status (name) VALUES ('Concluído');
INSERT INTO status (name) VALUES ('Cancelado');
INSERT INTO status (name) VALUES ('Aguardando pagamento');
INSERT INTO status (name) VALUES ('Pago');
INSERT INTO status (name) VALUES ('Reembolsado');
INSERT INTO status (name) VALUES ('Aguardando peças');

INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Reparo de notebook', '2024-10-01', '2024-10-05', 350.00, 1, 1, 1, 'Problema de superaquecimento');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Troca de tela de celular', '2024-10-02', '2024-10-06', 450.00, 2, 2, 2, 'Tela quebrada');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Instalação de SSD', '2024-09-30', '2024-10-04', 200.00, 3, 3, 3, 'Substituição de HD por SSD');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Manutenção em desktop', '2024-10-01', '2024-10-05', 300.00, 4, 4, 4, 'Reparação de fonte de alimentação');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Formatação de PC', '2024-10-03', '2024-10-07', 150.00, 5, 5, 5, 'Formatação e reinstalação do sistema');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Limpeza interna de notebook', '2024-09-29', '2024-10-03', 100.00, 6, 6, 6, 'Remoção de poeira');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Substituição de placa-mãe', '2024-10-01', '2024-10-10', 500.00, 7, 7, 7, 'Placa-mãe com defeito');
INSERT INTO customer_order (description, issue_date, end_date, price, customer_code, payment_method_code, status_code, observation)
VALUES ('Atualização de software', '2024-10-05', '2024-10-08', 250.00, 8, 8, 8, 'Atualização de drivers e sistema');

