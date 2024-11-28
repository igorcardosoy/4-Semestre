DROP ROLE MASTER;
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


-- A role User representará os usuários finais do sistema, que terão poder apenas para consultar os voos ativos.
CREATE ROLE USER;

GRANT CREATE SESSION TO USER;
GRANT VIEW ON Voos_Ativos TO USER;
GRANT VIEW on Assentos_disponiveis TO SELLER;

-- A role Maintainer representará os diversos manutenidores do sistema, os funcionários que realizam reparos, que possuirão poder para consultar e atualizar dados nas tabelas referentes as aeronaves. 
CREATE ROLE MANTAINER;

GRANT CREATE SESSION,
VIEW ON aeronaves_manutenir,
UPDATE TABLE ON AERONAVE,
UPDATE TABLE ON MANUTENCAO
TO MANTAINER; 

-- Já a role Seller representará os funcionários responsáveis por atualizar, cadastrar e editar os dados dos novos usuários, bem como vender passagens aéreas.
CREATE ROLE SELLER;
 
GRANT CREATE SESSION TO SELLER;

GRANT INSERT ON PASSAGEIRO TO SELLER;
GRANT INSERT ON VOO TO SELLER;
GRANT INSERT ON PASSAGEIRO_VOO TO SELLER;
 
GRANT SELECT ON PASSAGEIRO TO SELLER;
GRANT VIEW on Assentos_disponiveis TO SELLER;
GRANT VIEW on Voos_ativos TO SELLER;
 
GRANT UPDATE ON PASSAGEIRO TO SELLER;
GRANT UPDATE ON VOO TO SELLER;
GRANT UPDATE ON PASSAGEIRO_VOO TO SELLER;


-- A role Crew representará os funcionários que necessitam de saber apenas em quais voos estão alocados, garantindo visualizacao à ‘escala’ de funcionários x voos.
CREATE ROLE CREW; 

GRANT CREATE SESSION,  
SELECT TABLE ON PASSAGEIRO_VOO  
TO CREW;


-- Usuário adereçados aos mecânicos do sistema
CREATE USER MECANICO
IDENTIFIED BY PILOTPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;
ALTER USER AEROPORTO QUOTA UNLIMITED ON USERS;
 
GRANT MANTAINER TO MECANICO;