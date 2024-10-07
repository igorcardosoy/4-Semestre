CREATE DATABASE IFITNESS;

CREATE TABLE USER (
                      id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
                      name VARCHAR(50) NOT NULL,
                      email VARCHAR(50) NOT NULL,
                      password VARCHAR(150) NOT NULL,
                      birth_date DATE NOT NULL,
                      gender VARCHAR(30) NOT NULL,
                      active BOOLEAN NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SELECT * FROM USER;