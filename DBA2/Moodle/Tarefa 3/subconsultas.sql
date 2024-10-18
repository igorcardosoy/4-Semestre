
/*
* Igor Filipi Cardoso - AQ3022587
*/

-- Exercicio 1
/*1. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que trabalham no mesmo departamento que o empregado com sobrenome Zlotkey (excluindo ele próprio).*/
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID =
      (SELECT DEPARTMENT_ID
       FROM EMPLOYEES
       WHERE LAST_NAME = 'Zlotkey')
  AND LAST_NAME <> 'Zlotkey'
ORDER BY FIRST_NAME;

-- Exercicio 2
/*2. Consultar o primeiro nome, sobrenome e data de contratação dos empregados que foram contratados depois do empregado com sobrenome Davies.*/

SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >
      (SELECT HIRE_DATE
       FROM EMPLOYEES
       WHERE LAST_NAME = 'Davies')
ORDER BY HIRE_DATE;

-- Exercicio 3
/*3. Consultar os sobrenomes dos empregados que são gerentes de departamento*/

SELECT LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN
      (SELECT MANAGER_ID
       FROM DEPARTMENTS);

-- Exercicio 4
/*4. Consultar o sobrenome e o id do cargo dos empregados que não trabalham em departamentos que contêm a palavra ‘sales’ no nome do departamento.*/

SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN
      (SELECT DEPARTMENT_ID
       FROM DEPARTMENTS
       WHERE DEPARTMENT_NAME LIKE '%Sales%');

-- Exercicio 5
/*5. Consultar o sobrenome e o salário dos empregados cujo salário é menor que o salário de algum empregado com id de cargo ‘ST_MAN’.*/

SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (
    SELECT SALARY
    FROM EMPLOYEES
    WHERE JOB_ID = 'ST_MAN'
    );


-- Exercicio 6
/*Consultar o sobrenome e o salário dos empregados cujo salário é maior que o salário de todos os empregados do departamento com id = 50. */
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > all
      (SELECT SALARY
       FROM EMPLOYEES
       WHERE DEPARTMENT_ID = 50);

-- Exercicio 7
/*7. Consultar o primeiro nome, sobrenome e salário dos empregados que possuem o mesmo cargo que o empregado com sobrenome Zlotkey e ganham salário maior que ele.*/

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE JOB_ID =
      (SELECT JOB_ID
       FROM EMPLOYEES
       WHERE LAST_NAME = 'Zlotkey')
AND SALARY >
            (SELECT SALARY
            FROM EMPLOYEES
            WHERE LAST_NAME = 'Zlotkey');


-- Exercicio 8
/*8. Consultar id de países que possuem departamentos da empresa (usar EXISTS)*/

SELECT DISTINCT COUNTRY_ID
FROM LOCATIONS
WHERE EXISTS
      (SELECT *
       FROM DEPARTMENTS
       WHERE LOCATIONS.LOCATION_ID = DEPARTMENTS.LOCATION_ID);



