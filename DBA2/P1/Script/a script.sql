/*
Principais conceitos vistos, até o momento, na disciplina e exemplos de seu uso.

Cauã Rufino de Sá
Igor Filipi Cardoso

Domínio: Aeroporto
O sistema tem o objetivo de gerenciar as operações principais de um aeroporto, abrangendo o cadastro de voos, passageiros, funcionários, aeronaves e destinos, além de monitorar o embarque, desembarque e horários de partidas e chegadas.
*/


-- Criar role e user com o usuário SYSTEM
CREATE ROLE MASTER;

GRANT CREATE SESSION, 
      CREATE TABLE,
      CREATE SEQUENCE,  
      CREATE VIEW, 
      DROP ANY TABLE,
      INSERT ANY TABLE,  
      SELECT ANY TABLE, 
      ALTER ANY TABLE, 
      UPDATE ANY TABLE,  
      DELETE ANY TABLE,
      CREATE ANY VIEW,
      DROP ANY VIEW,
      GRANT ANY ROLE
TO MASTER;


CREATE USER AEROPORTO
IDENTIFIED BY AIRPORTPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT MASTER TO AEROPORTO;

-- Mudar para o usuário AEROPORTO

/*
* Questão 1
* 1. A criação de, pelo menos, 5 tabelas com suas devidas restrições de integridade (incluindo as chaves estrangeiras);
*/

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

-- Arquivos inserts, foi criado um arquivo inserts.sql, que é executado usando o comando @inserts.sql, para melhorar a visibilidade do código.
@inserts.sql;


/*
* Questão 2
* 2. A criação de 5 consultas complexas, com a explicação, para cada uma do porquê ela é uma consulta complexa
*/

-- Passageiros em voos nacionais
/*
* A consulta é complexa devido ao uso de NATURAL JOIN (que junta tabelas automaticamente) e DISTINCT (que elimina duplicatas), além de múltiplas junções e filtros específicos, o que aumenta a carga de processamento.
*/
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
/*
* A consulta é complexa devido ao uso de NATURAL JOIN (junção automática), DISTINCT (eliminação de duplicatas), múltiplas junções e a condição WHERE ampla, o que aumenta a carga de processamento.
*/
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
/*
*A consulta é complexa devido ao uso de UNION ALL para combinar dois conjuntos de dados, múltiplas junções e uma ordenação por várias colunas, o que aumenta o processamento e a complexidade.
*/
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

-- Quais aeronaves estão inativas atualmente, listar seu modelo, fabricante e a data da última manutenção realizada, e os voos internacionais no ano de 2024.
/*
* A consulta é complexa devido ao uso de DISTINCT, que exige a remoção de duplicatas, e às múltiplas junções entre tabelas (AERONAVE, MANUTENCAO, VOO, e aeroporto), o que pode resultar em um grande volume de dados combinados. Além disso, os filtros por data e país, a ordenação por a.MODELO e m.DATA_MANUTENCAO DESC, adicionam complexidade ao processo.
*/
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
ORDER BY a.MODELO, m.DATA_MANUTENCAO DESC;



--Identificar os aeroportos brasileiros que permitem voos internacionais que mais serviram como destino de voos no último ano e listar o nome do aeroporto, a cidade e o número total de voos recebidos.
/*
* A consulta é complexa devido ao uso de múltiplas junções entre tabelas (AEROPORTO e VOO), o uso de funções de agregação (COUNT) e GROUP BY, que exigem a combinação e a contagem de dados, e a ordenação por TotalVoos, o que aumenta a complexidade do processamento.
*/ 
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

-- Seleciona o fabricante e o custo médio de manutenção das aeronaves por fabricante, através de uma subconsulta que agrupa e seleciona todas as manutenções realizadas por fabricante.  
SELECT Fabricante, AVG(CustoTotal) AS MediaCusto 
FROM ( 
      SELECT a.FABRICANTE, 
      SUM(m.CUSTO) AS CustoTotal 
      FROM MANUTENCAO m 
      INNER JOIN AERONAVE a USING (AERONAVE_ID)
      GROUP BY a.FABRICANTE 
   ) 
GROUP BY Fabricante;

-- Seleciona o número do voo e a quantidade de funcionários presentes em cada voo, utilizando uma subconsulta que seleciona e conta cada funcionário presente em cada voo. 
SELECT v.numero_voo, ( 
      SELECT COUNT(*)   
      FROM funcionario_voo fv   
      WHERE fv.voo_id = v.voo_id  
    ) AS total_funcionarios  
FROM voo v;

-- Seleciona o nome e a quantidade de voos que cada passageiro realizou, através de uma subconsulta que seleciona a quantidade de ocorrências do id de cada passageiro. 
SELECT p.nome, ( 
   SELECT COUNT(*)  
   FROM passageiro_voo pv  
   WHERE pv.passageiro_id = p.passageiro_id 
) AS total_voos 
FROM passageiro p;



/*
* Questão 4
* A criação de, pelo menos, 3 visões. Dê preferência para as visões que teriam maior utilidade para os usuários e explique o motivo da sua escolha;
*/


-- A view voos_ativos exibirá os voos que estão ativos, ou seja, que ainda não ocorreram.
/*
* A view é útil para os usuários que desejam visualizar os voos que ainda estão programados para ocorrer, com informações detalhadas sobre a aeronave, a data de partida e chegada, e os aeroportos de origem e destino.
*/
CREATE VIEW voos_ativos AS
SELECT
    V.numero_voo,
    A.modelo,
    A.fabricante,
    V.data_partida,
    V.data_chegada,
    origem.nome AS origem,
    destino.nome AS destino
FROM voo V
      JOIN aeronave A USING (aeronave_id)
      JOIN aeroporto origem ON V.origem_id = origem.aeroporto_id
      JOIN aeroporto destino ON V.destino_id = destino.aeroporto_id
   WHERE V.status = 'Ativo';
    
-- A view aeronaves_manutenir exibirá as aeronaves inativas, listando seu modelo, fabricante e a data da última manutenção realizada.
/*
* A view é útil para os usuários que desejam visualizar as aeronaves inativas, com informações detalhadas sobre o modelo, o fabricante e a data da última manutenção realizada, o que pode ser útil para programar futuras manutenções.
*/
CREATE VIEW aeronaves_manutenir AS
SELECT
    A.modelo,
    A.fabricante,
    M.data_manutencao
FROM aeronave A, manutencao M
WHERE A.aeronave_id = M.aeronave_id
AND A.status = 'Inativa';

-- A view assentos_disponiveis exibirá a quantidade de assentos disponíveis em cada voo, subtraindo a capacidade da aeronave.
/*
* A view é útil para os usuários que desejam visualizar a quantidade de assentos disponíveis em cada voo, com informações detalhadas sobre o número do voo e a quantidade de assentos disponíveis, o que pode ser útil para planejar a venda de passagens.
*/
CREATE VIEW assentos_disponiveis AS
SELECT
      V.numero_voo,
      A.capacidade - COUNT(PV.assento) AS assentos_disponiveis
FROM voo V
      JOIN aeronave A USING (aeronave_id)
      LEFT JOIN passageiro_voo PV USING (voo_id)
GROUP BY V.numero_voo, A.capacidade;



/*
* Questão 5
* A criação de, pelo menos, 3 papéis (roles) e explicação do motivo da sua escolha;
*/

-- Criar com o usuário SYSTEM

-- A role Maintainer representará os diversos manutenidores do sistema, os funcionários que realizam reparos, que possuirão poder para consultar e atualizar dados nas tabelas referentes as aeronaves. 
/*
* A role é útil para os funcionários responsáveis pela manutenção das aeronaves, que precisam de acesso para consultar e atualizar dados nas tabelas de aeronaves e manutenção.
*/
CREATE ROLE MANTAINER;

GRANT CREATE SESSION TO MANTAINER;
GRANT SELECT ON AEROPORTO.aeronaves_manutenir TO MANTAINER;
GRANT SELECT ON AEROPORTO.aeronave TO MANTAINER;
GRANT SELECT ON AEROPORTO.manutencao TO MANTAINER;
GRANT UPDATE ON AEROPORTO.manutencao TO MANTAINER;

-- Já a role Seller representará os funcionários responsáveis por atualizar, cadastrar e editar os dados dos novos usuários, bem como vender passagens aéreas.
/*
* A role é útil para os funcionários que trabalham no balcão de vendas, que precisam de acesso para inserir e atualizar dados nas tabelas de passageiros, voos e passageiros_voo.
*/
CREATE ROLE SELLER;
 
GRANT CREATE SESSION TO SELLER;
GRANT INSERT ON AEROPORTO.PASSAGEIRO TO SELLER;
GRANT INSERT ON AEROPORTO.VOO TO SELLER;
GRANT INSERT ON AEROPORTO.PASSAGEIRO_VOO TO SELLER;
GRANT SELECT ON AEROPORTO.PASSAGEIRO TO SELLER;
GRANT UPDATE ON AEROPORTO.PASSAGEIRO TO SELLER;
GRANT UPDATE ON AEROPORTO.VOO TO SELLER;
GRANT UPDATE ON AEROPORTO.PASSAGEIRO_VOO TO SELLER;
GRANT SELECT on AEROPORTO.assentos_disponiveis TO SELLER;
GRANT SELECT on AEROPORTO.voos_ativos TO SELLER;


-- A role Crew representará os funcionários que necessitam de saber apenas em quais voos estão alocados, garantindo visualizacao à ‘escala’ de funcionários x voos.
/*
* A role é útil para os tripulantes, que precisam de acesso para consultar os voos em que estão alocados, sem a necessidade de atualizar ou inserir dados nas tabelas.
*/
CREATE ROLE CREW; 

GRANT CREATE SESSION TO CREW;
GRANT SELECT ON AEROPORTO.PASSAGEIRO_VOO TO CREW;

-- A role PASSENGER representará os usuários finais do sistema, que terão poder apenas para consultar os voos ativos.
/*
* A role é útil para os passageiros, que precisam de acesso para consultar os voos ativos, sem a necessidade de atualizar ou inserir dados nas tabelas.
*/
CREATE ROLE PASSENGER;

GRANT CREATE SESSION TO PASSENGER;
GRANT SELECT ON AEROPORTO.voos_Ativos TO PASSENGER;
GRANT SELECT on AEROPORTO.assentos_disponiveis TO SELLER;




/*
* Questão 6
* A criação de, pelo menos 5 usuários e a aplicação de seus papéis;
*/

-- Criar com o usuário SYSTEM

-- User AEROPORTO foi definido no início do script.

-- Usuário adereçados aos mecânicos do sistema
/*
* O usuário MECANICO foi criado com a role MANTAINER, que permite consultar e atualizar dados nas tabelas de aeronaves e manutenção.
*/
CREATE USER MECANICO
IDENTIFIED BY PILOTPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 5M ON USERS;
 
GRANT MANTAINER TO MECANICO;


-- Usuário adereçado aos vendedores do sistema
/*
* O usuário VENDEDOR foi criado com a role SELLER, que permite inserir e atualizar dados nas tabelas de passageiros, voos e passageiros_voo.
*/
CREATE USER VENDEDOR
IDENTIFIED BY SELLERPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 5M ON USERS;

GRANT SELLER TO VENDEDOR;


-- Usuário adereçado aos tripulantes funcionários do sistema
/*
* O usuário TRIPULANTE foi criado com a role CREW, que permite consultar os voos em que estão alocados.
*/
CREATE USER TRIPULANTE
IDENTIFIED BY CREWPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 5M ON USERS;

GRANT CREW TO TRIPULANTE;


-- Usuário adereçado aos passageiros do sistema
/*
* O usuário PASSAGEIRO foi criado com a role PASSENGER, que permite consultar os voos ativos.
*/
CREATE USER PASSAGEIRO
IDENTIFIED BY PASSENGERPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 5M ON USERS;

GRANT PASSENGER TO PASSAGEIRO;
