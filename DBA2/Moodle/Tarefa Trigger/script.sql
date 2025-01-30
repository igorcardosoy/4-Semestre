--Exercicio 1
CREATE OR REPLACE TRIGGER att_total_salario
    AFTER INSERT OR UPDATE OR DELETE ON emp.Funcionarios
    FOR EACH ROW
DECLARE
    old_salario NUMBER;
BEGIN

    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Novo funcionário inserido');
            UPDATE departamentos 
            SET total_salarios = total_salarios + :NEW.SALARIO
            where codigo = :new.cod_depto;
        WHEN UPDATING('SALARIO') THEN
            DBMS_OUTPUT.PUT_LINE('Funcionário atualizado: salario');
            UPDATE departamentos 
            SET total_salarios = total_salarios + (:NEW.SALARIO - :old.SALARIO)
            where codigo = :new.cod_depto;
        WHEN DELETING THEN
            DBMS_OUTPUT.PUT_LINE('Funcionário deletado!');
            UPDATE departamentos 
            SET total_salarios = total_salarios - :old.SALARIO
            where codigo = :old.cod_depto;
    END CASE;

    DBMS_OUTPUT.PUT_LINE('TOTAL SALARIO ATUALIZADO!');
END;


--Exercicio 2
CREATE OR REPLACE TRIGGER att_salario
    AFTER INSERT OR UPDATE OR DELETE ON emp.Funcionarios
    FOR EACH ROW
DECLARE
    old_salario NUMBER;
BEGIN

    CASE
        WHEN INSERTING THEN
            DBMS_OUTPUT.PUT_LINE('Novo funcionário inserido');
            INSERT INTO log_salarios (cod_func, data_log, sal_antigo, sal_novo)
            VALUES (new.codigo, SYSDATE, 0, new.salario);
        WHEN UPDATING('SALARIO') THEN
            DBMS_OUTPUT.PUT_LINE('Funcionário atualizado: salario');
            INSERT INTO log_salarios (cod_func, data_log, sal_antigo, sal_novo)
            VALUES (new.codigo, SYSDATE, old.salario, new.salario);
        WHEN DELETING THEN
            DBMS_OUTPUT.PUT_LINE('Funcionário deletado!');
            DBMS_OUTPUT.PUT_LINE('Funcionário atualizado: salario');
            INSERT INTO log_salarios (cod_func, data_log, sal_antigo, sal_novo)
            VALUES (new.codigo, SYSDATE, old.salario, 0);
    END CASE;

    DBMS_OUTPUT.PUT_LINE('LOG SALARIO ATUALIZADO!');
END;