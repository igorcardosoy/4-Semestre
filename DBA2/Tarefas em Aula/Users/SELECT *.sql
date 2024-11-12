SELECT *
FROM DBA_USERS
WHERE USERNAME like 'USUARIO%';

SELECT *
FROM DBA_TS_QUOTAS
WHERE USERNAME like 'USUARIO%';

CREATE USER usuario1
    IDENTIFIED BY usuario1
    DEFAULT TABLESPACE users
    QUOTA 5M ON users
    TEMPORARY TABLESPACE temp;

CREATE USER usuario2
    IDENTIFIED BY usuario2
    DEFAULT TABLESPACE users
    QUOTA 5M ON users
    TEMPORARY TABLESPACE temp;


SELECT *
FROM DBA_SYS_PRIVS
where grantee like 'USUARIO%';

SHOW USER;

GRANT CREATE SESSION,
    CREATE TABLE
    TO usuario2;

GRANT CREATE SESSION,
    CREATE TABLE
    TO usuario1;


CREATE ROLE admin2;

GRANT CREATE SESSION,
    CREATE TABLE,
    CREATE VIEW,
    CREATE SEQUENCE,
    CREATE PROCEDURE
    TO admin2;

GRANT admin2 TO usuario2;


-- Exercicio 1

/*
Atribuir ao usuario2 os privilégios de:
◦ inserir tuplas na tabela funcionario de usuario1
◦ atualizar salario da tabela funcionario de
usuario1
*/

/*Funcionario(cod_func, nome, salario)*/

CREATE TABLE usuario1.funcionario
(
    cod_func NUMBER(5) PRIMARY KEY,
    nome VARCHAR2(50),
    salario NUMBER(10,2)
);

GRANT INSERT, UPDATE
    ON usuario1.funcionario
    TO usuario2;

GRANT UPDATE
    ON usuario1.funcionario
    to usuario2;

INSERT INTO usuario1.funcionario VALUES (1, 'João', 1000);
UPDATE usuario1.funcionario SET salario = 2000 WHERE cod_func = 1;


/*
Atribuir ao usuario1 o privilégio de consultar
os dados da tabela emp de usuario2
*/

CREATE TABLE usuario2.emp
(
    cod_emp NUMBER(5) PRIMARY KEY,
    nome VARCHAR2(50),
    salario NUMBER(10,2)
);

GRANT SELECT
    ON usuario2.emp
    TO usuario1;

SELECT * FROM usuario2.emp;


/*
Atribuir a qualquer usuário o privilégio de
consulta aos dados da tabela funcionario de
usuario1
*/

GRANT SELECT
    ON usuario1.funcionario
    TO PUBLIC;

SELECT * FROM usuario1.funcionario;

GRANT INSERT
    ON usuario2.emp
    TO PUBLIC;

REVOKE INSERT
    ON usuario2.emp
    FROM PUBLIC;

REVOKE ALL
    ON usuario1.funcionario
    FROM usuario2;














