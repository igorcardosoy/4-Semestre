/*1. Consultar sobrenome e salário dos empregados cujo título do cargo é ‘Sales Representative’ ou
‘Stock Clerk’;*/

SELECT last_name, salary
FROM employees E
NATURAL JOIN jobs J
WHERE J.job_title = 'Sales Representative'
   OR J.job_title = 'Stock Clerk';

/*2. Consultar os nomes dos países e os nomes das regiões onde estão localizados;*/

SELECT country_name, region_name
FROM countries C NATURAL JOIN regions R;

/*3. Consultar o nome do departamento e sobrenome de seu gerente, considerando gerentes de
departamento com salário menor que 10000;*/

SELECT D.department_name, E.last_name
FROM departments D
         JOIN employees E ON D.manager_id = E.employee_id
WHERE E.salary < 10000;

/*4. Consultar primeiro nome e sobrenome dos empregados que trabalham em departamentos
localizados em cidades cujo nome inicia-se com a letra S;*/

SELECT first_name, last_name
FROM employees E
        INNER JOIN departments D USING (department_id)
        INNER JOIN locations L USING (location_id)
WHERE L.city LIKE 'S%';

/*5. Consultar sobrenome e nome do departamento para os empregados que trabalham em
departamentos localizados na região com nome ‘Europe’;*/

SELECT last_name, department_name
FROM employees E
        INNER JOIN departments D USING (department_id)
        INNER JOIN locations L USING (location_id)
        INNER JOIN countries C USING (country_id)
        INNER JOIN regions R ON C.REGION_ID = R.REGION_ID
            AND R.region_name LIKE 'Europe';

/*6. Faça uma consulta para elaborar um relatório dos empregados e seus respectivos gerentes
contendo sobrenome do empregado, id de seu cargo (job_id), sobrenome do seu gerente e id do
cargo (job_id) do gerente;*/

SELECT E.last_name AS employee_last_name,
       E.job_id AS employee_job_id,
       M.last_name AS manager_last_name,
       M.job_id AS manager_job_id
FROM employees E
         LEFT JOIN employees M ON E.manager_id = M.employee_id;

/*7. Para todos os departamentos cadastrados, mesmo para aqueles que não tenham gerente,
consulte o nome do departamento e o sobrenome de seu gerente;*/

SELECT D.department_name, E.last_name AS manager_last_name
FROM departments D
         LEFT OUTER JOIN employees E ON D.manager_id = E.employee_id;

/*8. Considerando o histórico de cargos (tabela JOB_HISTORY), consulte sobrenome do
empregado, id de cargo (job_id), data de início e data de encerramento registrados no histórico,
considerando todos empregados cadastrados, incluindo também aqueles que não possuem
registro no histórico de cargos.*/

SELECT e.last_name, e.job_id, j.start_date, j.end_date
FROM employees e
LEFT OUTER JOIN job_history j USING (employee_id);