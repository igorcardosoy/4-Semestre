-- Inserindo dados na tabela ADDRESS
INSERT INTO ADDRESS (STREET, NUMBER, COMPLEMENT, NEIGHBORHOOD, CITY, STATE, ZIPCODE)
VALUES ('Rua das Laranjeiras', '10', 'Apto 202', 'Centro', 'Araraquara', 'São Paulo', '14800-100'),
       ('Avenida Paulista', '200', NULL, 'Bela Vista', 'São Paulo', 'São Paulo', '01310-000'),
       ('Rua XV de Novembro', '50', 'Casa', 'Centro', 'Campinas', 'São Paulo', '13000-150'),
       ('Rua da Praia', '1000', 'Cobertura', 'Gonzaga', 'Santos', 'São Paulo', '11060-000'),
       ('Avenida Atlântica', '300', 'Apto 101', 'Copacabana', 'Rio de Janeiro', 'Rio de Janeiro', '22000-000');

-- Inserindo dados na tabela CUSTOMER
INSERT INTO CUSTOMER (CODE, NAME, EMAIL, PHONE, CPF, ADDRESS_ID)
VALUES (100001, 'Carlos Souza', 'carlos.souza@gmail.com', '(11) 99999-9999', '123.456.789-00', 1),
       (100002, 'Ana Oliveira', 'ana.oliveira@yahoo.com', '(21) 98888-8888', '987.654.321-11', 2),
       (100003, 'Marcos Silva', 'marcos.silva@outlook.com', '(19) 97777-7777', '321.654.987-22', 3),
       (100004, 'Fernanda Costa', 'fernanda.costa@hotmail.com', '(13) 96666-6666', '654.987.321-33', 4),
       (100005, 'João Santos', 'joao.santos@gmail.com', '(21) 95555-5555', '789.123.456-44', 5);

-- Inserindo dados na tabela PAYMENT_METHOD
INSERT INTO PAYMENT_METHOD (CODE, NAME)
VALUES (5001, 'Cartão de Crédito'),
       (5002, 'Boleto Bancário'),
       (5003, 'Pix'),
       (5004, 'Transferência Bancária'),
       (5005, 'Dinheiro');

-- Inserindo dados na tabela ORDER_STATUS
INSERT INTO ORDER_STATUS (CODE, NAME)
VALUES (6001, 'Pendente'),
       (6002, 'Em Andamento'),
       (6003, 'Concluído'),
       (6004, 'Cancelado');

-- Inserindo dados na tabela CUSTOMER_ORDER
INSERT INTO CUSTOMER_ORDER (CODE, DESCRIPTION, ISSUE_DATE, END_DATE, PRICE, CUSTOMER_CODE, PAYMENT_METHOD_CODE,
                            STATUS_CODE, OBSERVATION)
VALUES (700001, 'Troca de tela de smartphone', '2024-10-01', '2024-10-03', 300.00, 100001, 5001, 6003,
        'Troca de tela de iPhone'),
       (700002, 'Formatação de notebook', '2024-09-25', '2024-09-27', 150.00, 100002, 5002, 6003,
        'Formatação e instalação de Windows'),
       (700003, 'Reparo de impressora', '2024-10-10', '2024-10-15', 200.00, 100003, 5003, 6002,
        'Substituição de cabeçote'),
       (700004, 'Instalação de roteador', '2024-10-05', '2024-10-06', 120.00, 100004, 5004, 6003, NULL),
       (700005, 'Troca de bateria de notebook', '2024-09-30', '2024-10-02', 180.00, 100005, 5005, 6001,
        'Bateria não original disponível no mercado');
