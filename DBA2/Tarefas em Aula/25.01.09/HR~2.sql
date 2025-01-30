SELECT
    *
FROM
    hr.departments;

SELECT
    *
FROM
    hr.employees;

EXEC add_dept;

EXEC att_dept;

EXEC add_dept_manager('Administration', 118);

EXEC add_location_dept('Noc', 'Roma');

DECLARE
    x INTEGER := 10;
    y INTEGER := 2;
    z INTEGER;
    w FLOAT := 6;
BEGIN
    dbms_output.put_line('ANTES do procedimento p:');
    dbms_output.put_line('x = ' || x);
    dbms_output.put_line('y = ' || y);
    dbms_output.put_line('z = ' || z);
    dbms_output.put_line('w = ' || w);
    p(x, y, z, w);
    dbms_output.put_line('DEPOIS do procedimento p:');
    dbms_output.put_line('x = ' || x);
    dbms_output.put_line('y = ' || y);
    dbms_output.put_line('z = ' || z);
    dbms_output.put_line('w = ' || w);
END;

BEGIN
    IF ( check_sal(103) ) THEN
        dbms_output.put_line('Salário > média');
    ELSE
        dbms_output.put_line('Salário < média');
    END IF;
END;

DECLARE
    empno employees.employee_id%TYPE := &empno;
BEGIN   
    dbms_output.put_line(qtd_salario_maior(empno)
                         || '
empregados ganham mais que o empregado '
                         || empno);
END;