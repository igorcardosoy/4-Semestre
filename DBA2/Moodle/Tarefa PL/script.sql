DECLARE
  funccode      employees.employee_id%TYPE;
  funcfirstname employees.first_name%TYPE;
  funclastname  employees.last_name%TYPE;
  hiredate      employees.hire_date%TYPE;
  yearsworked   NUMBER(3);
  actualsalary  employees.salary%TYPE;
  bonussalary   employees.salary%TYPE := 0;
BEGIN
  funccode := &funccode;
  SELECT e.first_name,
         e.last_name,
         e.hire_date,
         e.salary
    INTO
    funcfirstname,
    funclastname,
    hiredate,
    actualsalary
    FROM employees e
   WHERE e.employee_id = funccode;

  yearsworked := trunc(months_between(
    sysdate,
    hiredate
  ) / 12);
  IF yearsworked > 0 THEN
    bonussalary := yearsworked * 50;
  END IF;
  dbms_output.put_line('Código do Funcionário: ' || funccode);
  dbms_output.put_line('Nome: ' || funcfirstname);
  dbms_output.put_line('Sobrenome: ' || funclastname);
  dbms_output.put_line('Data de Contratação: ' || hiredate);
  dbms_output.put_line('Anos Trabalhados: ' || yearsworked);
  dbms_output.put_line('Salário Atual: ' || actualsalary);
  dbms_output.put_line('Bônus: ' || bonussalary);
END;