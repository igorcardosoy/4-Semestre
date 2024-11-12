/*
1. Crie o usuário usuario3 que deve relacionar os funcionários em usuario1 com os empregados em usuario2 por meio da tabela:
    > Trabalha_com(cod_func, emp_id, data)
        cod_func é definido em usuario1.Funcionario
        emp_id é definido em usuario2.Emp
*/

/*
2. usuario3 também deve ser capaz de consultar os nomes de funcionários e de empregados que trabalharam juntos.
*/

CREATE USER usuario3 IDENTIFIED BY usuario3;

ALTER USER usuario3
   DEFAULT TABLESPACE users
   QUOTA 5M ON users
   TEMPORARY TABLESPACE temp;

GRANT
   CREATE SESSION,
   CREATE TABLE,
   CREATE VIEW
TO usuario3;

GRANT REFERENCES ( cod_func ) ON usuario1.funcionario TO usuario3;
GRANT REFERENCES ( cod_emp ) ON usuario2.emp TO usuario3;


CREATE TABLE usuario3.trabalha_com (
   cod_func INT,
   cod_emp  INT,
   data     DATE,
   FOREIGN KEY ( cod_func )
      REFERENCES usuario1.funcionario ( cod_func ),
   FOREIGN KEY ( cod_emp )
      REFERENCES usuario2.emp ( cod_emp )
);


CREATE VIEW usuario3.func_emp AS
   SELECT f.nome AS nome_func,
          e.nome AS nome_emp
     FROM usuario1.funcionario f
     JOIN usuario3.trabalha_com tc
   USING ( cod_func )
     JOIN usuario2.emp e
   ON tc.cod_emp = e.cod_emp;

SELECT *
  FROM usuario3.func_emp;

/*
3. Explique o que o comando faz
    CREATE USER pedro
    IDENTIFIED BY my1stson
    DEFAULT TABLESPACE data
    TEMPORARY TABLESPACE temp
    QUOTA 15m ON data
    PASSWORD EXPIRE;
*/

CREATE USER pedro IDENTIFIED BY my1stson
   DEFAULT TABLESPACE data
   TEMPORARY TABLESPACE temp
   QUOTA 15m ON data
   PASSWORD EXPIRE;

/*
    O comando cria um usuário chamado pedro com a senha my1stson, 
    que tem como tablespace padrão data e tablespace temporário temp.
    O usuário pedro tem uma cota de 15MB na tablespace data e a senha expira.

    O comando da erro, pois não existe a tablespace data.
*/


/*
4. Crie o script para reproduzir o seguinte esquema de roles e usuários.
*/

CREATE ROLE hr_mgr;

GRANT
   CREATE TABLE,
   CREATE SESSION
TO hr_mgr;

GRANT SELECT ON usuario2.emp TO hr_mgr;

CREATE ROLE hr_clerk;

GRANT
   CREATE SESSION
TO hr_clerk;

GRANT SELECT ON usuario2.emp TO hr_clerk;
GRANT INSERT ON usuario2.emp TO hr_clerk;
GRANT UPDATE ON usuario2.emp TO hr_clerk;


CREATE USER user_a IDENTIFIED BY user_a;

ALTER USER user_a
   DEFAULT TABLESPACE users
   QUOTA 5M ON users
   TEMPORARY TABLESPACE temp;

GRANT hr_mgr TO user_a;
GRANT hr_clerk TO user_a;


CREATE USER user_b IDENTIFIED BY user_b;

ALTER USER user_b
   DEFAULT TABLESPACE users
   QUOTA 5M ON users
   TEMPORARY TABLESPACE temp;

GRANT hr_clerk TO user_b;


CREATE USER user_c IDENTIFIED BY user_c;

ALTER USER user_c
   DEFAULT TABLESPACE users
   QUOTA 5M ON users
   TEMPORARY TABLESPACE temp;

GRANT hr_mgr TO user_c;


SELECT *
  FROM user_tab_privs_made;

SELECT *
  FROM role_sys_privs
 WHERE role IN ( 'HR_MGR',
                 'HR_CLERK' );