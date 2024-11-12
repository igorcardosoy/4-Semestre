-- Exercícios visões (VIEWS)

-- 1. Criar uma view EMP_ST_CLERK que contenha dados dos empregados com função ‘ST_CLERK’
-- Colunas: employee_id, last_name, email, hire_date, job_id
CREATE OR REPLACE VIEW EMP_ST_CLERK AS
SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'ST_CLERK';

-- 2. Criar (ou alterar) a view de modo que não seja possível alterar seu conteúdo com funções de empregado diferentes de ‘ST_CLERK’
CREATE OR REPLACE VIEW EMP_ST_CLERK AS
SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID = 'ST_CLERK'
WITH CHECK OPTION;

-- 3. Adicionar um novo empregado na view EMP_ST_CLERK com a função ‘ST_CLERK’
INSERT INTO EMP_ST_CLERK (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES (999, 'Cardoso', 'igor.cardoso', SYSDATE, 'ST_CLERK');

-- 4. Explicação: O que aconteceu na tabela Employees?
-- Foi inserido um novo registro com o ID 999 na tabela Employees, refletindo na view EMP_ST_CLERK.

-- 5. Atualizar o último nome do empregado adicionado na view EMP_ST_CLERK
UPDATE EMP_ST_CLERK
SET LAST_NAME = 'Filipi'
WHERE EMPLOYEE_ID = 999;

-- 6. Explicação: O que aconteceu?
-- Ocorreu uma violação da cláusula CHECK OPTION, pois tentamos mudar o job_id para um valor que não é permitido na view.

-- 7. Remover da view o empregado adicionado anteriormente
DELETE FROM EMP_ST_CLERK
WHERE EMPLOYEE_ID = 999;

-- 8. Explicação: O que aconteceu na tabela Employees?
-- O empregado com ID 999 foi removido da tabela Employees e, consequentemente, da view EMP_ST_CLERK.

-- 9. Criar uma visão DEPT_MAN_VIEW que contenha dados dos gerentes de departamento
-- Colunas: nome do gerente, título de sua função, salário anual, nome do departamento, cidade
CREATE OR REPLACE VIEW DEPT_MAN_VIEW AS
SELECT E.FIRST_NAME AS Nome_Gerente,
       E.JOB_ID AS Titulo_Funcao,
       E.SALARY AS Salario_Anual,
       D.DEPARTMENT_NAME AS Nome_Departamento,
       L.CITY AS Cidade
FROM EMPLOYEES E
         JOIN DEPARTMENTS D USING (DEPARTMENT_ID)
         JOIN LOCATIONS L USING (LOCATION_ID)
WHERE D.MANAGER_ID = E.EMPLOYEE_ID;

SELECT * FROM DEPT_MAN_VIEW

-- 10. É possível atualizar DEPT_MAN_VIEW? Justifique.
-- Tentativa de atualização
UPDATE DEPT_MAN_VIEW
SET Cidade = 'Araraquara'
WHERE Nome_Gerente = 'Victor';

-- Explicação: Sim, é possível atualizar pois a view não utiliza funções complexas nem agrega dados.

-- 11. Criar uma visão DEPT_JOB_VIEW que contenha uma relação da quantidade de empregados por função e por nome de departamento
-- Colunas: nome do departamento, nome da função, quantidade de empregados que exercem a função no referido departamento.
CREATE OR REPLACE VIEW DEPT_JOB_VIEW AS
SELECT D.DEPARTMENT_NAME AS Nome_Departamento,
       E.JOB_ID AS Nome_Funcao,
       COUNT(*) AS Quantidade_Empregados
FROM DEPARTMENTS D
         JOIN EMPLOYEES E USING (DEPARTMENT_ID)
GROUP BY D.DEPARTMENT_NAME, E.JOB_ID;

-- Consulta para verificar a view DEPT_JOB_VIEW
SELECT * FROM DEPT_JOB_VIEW;

-- 12. É possível atualizar DEPT_JOB_VIEW? Justifique.
-- Tentativa de atualização
UPDATE DEPT_JOB_VIEW
SET Nome_Departamento = 'TI'
WHERE Nome_Departamento = 'IT';

-- Explicação: Não é possível atualizar esta view pois ela utiliza agregação de dados (COUNT), 
-- o que impossibilita a atualização direta.
