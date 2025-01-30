/*
    1. Elabore uma função que, dado o id do empregado, retorne quantos empregados são mais antigos que ele na empresa.
*/
CREATE OR REPLACE FUNCTION empregados_antigos(
    emp_id employees.employee_id%TYPE
) RETURN NUMBER IS
    qtd NUMBER;
BEGIN 
    SELECT COUNT(*)
    INTO qtd
    FROM employees
    WHERE hire_date < (SELECT hire_date FROM employees WHERE employee_id = 100);
    
    
    RETURN qtd;
END;

BEGIN
        dbms_output.put_line(empregados_antigos(103));
END;



/*
    2. Faça uma função que, dados first_name, last_name e nome da empresa, retorne um endereço de email com o seguinte formato: first_name.last_name@nome_empresa.com
*/
CREATE OR REPLACE FUNCTION new_email(
    first_name employees.first_name%TYPE,
    last_name employees.last_name%TYPE,
    business_name VARCHAR2
) RETURN VARCHAR2 IS
BEGIN 
    RETURN LOWER(first_name || '.' || last_name || '@' || business_name || '.com');
END;


BEGIN
    dbms_output.put_line(new_email('Igor', 'Cardoso', 'IFSP'));
END;


/*
    3. Faça um procedimento para atualizar o email de um determinado empregado, com os parâmetros: id do empregado e nome da empresa. Utilize a função criada no exercício 1 para gerar o endereço de e-mail.
*/


CREATE OR REPLACE PROCEDURE att_email (
    emp_id employees.employee_id%TYPE,
    business_name VARCHAR2
) IS 
    email employees.email%TYPE;
    first_name employees.first_name%TYPE;
    last_name employees.last_name%TYPE;
BEGIN
    SELECT e.first_name, e.last_name 
    into first_name, last_name
    from EMPLOYEES e
    where e.employee_id = emp_id;
    
    email := new_email(first_name, last_name, business_name);
    
    UPDATE employees e
    SET e.email = email
    where e.employee_id = emp_id;  
END;

EXEC att_email(100, 'ifsp');

SELECT * FROM hr.employees;
    
/*
    4. Criar a função emp_status (emp_id) RETURN varchar2, que retorne o status de um funcionário
    com relação aos anos de trabalho na empresa:
    Maior que 12 anos: status = ‘master’
    Entre 8 e 12 anos: status = ‘senior’
    Menor que 8 anos: status = ‘pleno’
    Executar a function
    SELECT first_name, last_name, emp_status(employee_id)
    FROM employees;
*/

CREATE OR REPLACE FUNCTION emp_status (
    emp_id employees.employee_id%TYPE
) RETURN VARCHAR2 IS
    years_worked NUMBER;
    hire_date      employees.hire_date%TYPE;
BEGIN

    SELECT e.hire_date
    into hire_date
    from employees e
    where e.employee_id = emp_id;

    years_worked := trunc(months_between(sysdate, hire_date) / 12);
  
    IF years_worked < 8 THEN
        RETURN 'pleno';
    ELSIF years_worked < 12 THEN
        RETURN 'senior';
    ELSE
        RETURN 'master';
    END IF;
    
END;


SELECT first_name, last_name, emp_status(employee_id) FROM employees;


/*
5. Criar o procedimento aumento_salario (emp_id) que aumente o salário de um determinado
empregado com relação ao seu status
Master aumento de 10%
Senior aumento de 5%
Pleno sem aumento
Use a função emp_status para saber qual o status do empregado
*/

CREATE OR REPLACE PROCEDURE aumento_salario (
    emp_id employees.employee_id%TYPE
) IS 
    cargo VARCHAR2(10);
    aumento NUMBER;
BEGIN
    cargo := emp_status(emp_id);
    
    IF cargo = 'master' THEN
        aumento := 10;
    ELSIF cargo = 'senior' THEN
        aumento := 5;
    ELSE
        aumento := 0;
    END IF;
    
    UPDATE employees e
    SET e.salary = (e.salary * ((aumento / 100) + 1))
    WHERE e.employee_id = emp_id; 
END;

exec aumento_salario(100);


