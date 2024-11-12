CREATE TABLE usuario3.trabalha_com(
    cod_func INT,
    emp_id INT,
    FOREIGN KEY (cod_func) REFERENCES usuario1.funcionario(cod_func),
    FOREIGN KEY (emp_id) REFERENCES usuario2.emp(emp_id)
);

SELECT * FROM usuario3.func_emp;