/*
Questão 1. [JOIN]. Selecione as colunas first_name, last_name, department_name, city,
country_name fazendo união da tabela employees com as tabelas necessárias. Mostre
todos funcionários, exceto os que trabalham nos países 'Germany' e 'United Kingdom'
*/

SELECT E.first_name, 
    E.last_name, 
    D.department_name, 
    L.city,
    C.country_name
FROM employees E
INNER JOIN departments D USING (department_id)
INNER JOIN locations L USING (location_id)
INNER JOIN countries C USING (country_id)
WHERE C.country_name NOT LIKE 'Germany' AND C.country_name NOT LIKE 'United Kingdom%';


/*
Questão 2. [JOIN] Selecione first_name, last_name, department_name, location_id
mostrando todos funcionários que estão em departamentos e os departamentos sem
funcionários.
*/

SELECT 
    D.department_name,
    E.first_name, 
    E.last_name,
    D.location_id
FROM departments D 
    LEFT JOIN employees E USING (department_id);


/*
Questão 3. [JOIN] Selecione first_name, last_name, department_name, location_id
mostrando todos funcionários que estão em departamentos, os funcionários que não
estão em nenhum departamento e os departamentos sem funcionários
*/

SELECT E.first_name, 
    E.last_name, 
    D.department_name,
    D.location_id
FROM employees E FULL JOIN departments D ON e.department_id = d.department_id;


/*
Questão 4. [GROUP BY] Mostre o job_id, a soma de salários, a média de salários, o
maior salário e o menor salário dos funcionários, agrupados por job_id.
*/

SELECT E.JOB_ID, SUM(SALARY), ROUND(AVG(salary)), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES E
GROUP BY JOB_ID;


/*
Questão 5. [HAVING] Selecione o department_id, a soma de salários, a média de
salários, o maior salário e o menor salário dos funcionários, agrupados por
department_id. Mostre somente as linhas cuja média salarial seja maior ou igual a dez
mil (10000).
*/

SELECT DISTINCT E.DEPARTMENT_ID, SUM(SALARY), ROUND(AVG(salary)), MAX(SALARY), MIN(SALARY)
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID
HAVING AVG(SALARY) >= 10000;

/*
Questão 6. [UNION] Mostre as colunas employee_id, job_id, department_id, hire_date,
end_date utilizando o operador de conjunto UNION entre as tabelas employees e
job_history.
*/

SELECT E.EMPLOYEE_ID, E.JOB_ID, E.DEPARTMENT_ID, E.HIRE_DATE, NULL AS END_DATE
FROM EMPLOYEES E
UNION
SELECT JH.EMPLOYEE_ID, JH.JOB_ID, JH.DEPARTMENT_ID, NULL, JH.END_DATE
FROM JOB_HISTORY JH;



/*
Questão 7. [SUBCONSULTA] Selecione todas as localizações que estão no mesmo
país que a localização 1200, exceto a própria localização 1200. Mostre as colunas
location_id, street_address e country_id. Utilize subconsulta.
*/

SELECT L.location_id, L.street_address, L.country_id
FROM LOCATIONS L 
WHERE L.COUNTRY_ID = (
    SELECT LOC.country_id
    FROM LOCATIONS LOC 
    WHERE LOC.LOCATION_ID = 1200
) AND L.LOCATION_ID <> 1200;

/*
Questão 8. [SUBCONSULTA] Selecione todas as localizações que NÃO estão nos
mesmos países que as localizações das cidades 'ROMA', 'LONDON', 'TOKYO'. Mostre
as colunas location_id, street_address e country_id. Utilize subconsulta.
*/

SELECT location_id, street_address, country_id
FROM LOCATIONS
WHERE country_id NOT IN (
    SELECT L.COUNTRY_ID 
    FROM locations L
    WHERE UPPER(L.CITY) IN ('TOKYO', 'ROMA', 'LONDON')
);


/*
Questão 9. [VIEW] Crie uma view read only com base na tabela LOCATIONS. Nomeie
a view como read_LOCATIONS. Selecione as colunas location_id, street_address,
postal_code, city e country_id a serem incluídas na view. Adicione uma cláusula
WHERE para restringir country_id != 'IT'.
*/

CREATE  OR REPLACE VIEW read_LOCATIONS AS
    SELECT 
        location_id, 
        street_address, 
        postal_code, 
        city, 
        country_id
    FROM LOCATIONS
    WHERE COUNTRY_ID <> 'IT'
WITH READ ONLY;

SELECT * FROM READ_LOCATIONS;

