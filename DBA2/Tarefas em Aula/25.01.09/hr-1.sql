SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE add_dept IS
    dept_id   departments.department_id%TYPE;
    dept_name departments.department_name%TYPE;
BEGIN
    SELECT
        MAX(department_id)
    INTO dept_id
    FROM
        departments;

    dept_name := 'Novo Departamento';
    INSERT INTO departments (
        department_id,
        department_name
    ) VALUES ( ( dept_id + 1 ),
               dept_name );

    dbms_output.put_line('Inserida '
                         || SQL%rowcount
                         || ' linha.');
END;

--Fixação 1 - Procedure para att o nome do dep 171

CREATE OR REPLACE PROCEDURE att_dept IS
BEGIN
    UPDATE departments d
    SET
        department_name = 'Department X'
    WHERE
        department_id = 271;

    dbms_output.put_line('Inserida '
                         || SQL%rowcount
                         || ' linha.');
END;

CREATE OR REPLACE PROCEDURE add_dept_manager (
    dept_name departments.department_name%TYPE,
    emp_id    employees.employee_id%TYPE
) IS
BEGIN
    UPDATE departments
    SET
        manager_id = emp_id
    WHERE
        upper(department_name) = upper(dept_name);

    dbms_output.put_line('Atualizada(s) '
                         || SQL%rowcount
                         || ' tupla(s)');
END;
/

CREATE OR REPLACE PROCEDURE p (
    a INTEGER,
    b IN INTEGER,
    c OUT INTEGER,
    d IN OUT FLOAT
) IS
BEGIN
    dbms_output.put_line('Dentro do procedimento p:');
    dbms_output.put_line('IN a = ' || a);
    dbms_output.put_line('IN b = ' || b);
    dbms_output.put_line('OUT c = ' || c);
    dbms_output.put_line('IN OUT d = ' || d);
    c := a + b;
    d := a / b;
END;

-- Criar o procedimento add_location_dept para atribuir o
--location_id para um departamento da tabela DEPT passando
--como parâmetros:
--◦ Nome do departamento a ser atualizado
--◦ Nome da cidade onde o departamento se localiza
-- O location_id do departamento deve ser o maior location_id da
-- cidade passada como parâmetro

CREATE OR REPLACE PROCEDURE add_location_dept (
    dep_name  departments.department_name%TYPE,
    city_name locations.city%TYPE
) IS
    location_id_max locations.location_id%TYPE;
BEGIN
    dbms_output.put_line('Inicio do procedimento...');
    SELECT
        MAX(location_id)
    INTO location_id_max
    FROM
        locations l
    WHERE
        upper(l.city) = upper(city_name);

    UPDATE departments d
    SET
        location_id = location_id_max
    WHERE
        upper(d.department_name) = upper(dep_name);

END;

CREATE OR REPLACE FUNCTION check_sal (
    empno employees.employee_id%TYPE
) RETURN BOOLEAN IS

    dept_id employees.department_id%TYPE;
    sal     employees.salary%TYPE;
    avg_sal employees.salary%TYPE;
BEGIN
    SELECT
        salary,
        department_id
    INTO
        sal,
        dept_id
    FROM
        employees
    WHERE
        employee_id = empno;

    SELECT
        AVG(salary)
    INTO avg_sal
    FROM
        employees
    WHERE
        department_id = dept_id;

    IF sal > avg_sal THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END;

CREATE OR REPLACE FUNCTION qtd_salario_maior (
    empno employees.employee_id%TYPE
) RETURN NUMBER IS
    qtd NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO qtd
    FROM
        employees
    WHERE
        salary > (
            SELECT
                salary
            FROM
                employees
            WHERE
                employee_id = empno
        );

    RETURN qtd;
END;