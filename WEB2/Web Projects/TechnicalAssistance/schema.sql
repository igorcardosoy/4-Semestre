DROP DATABASE IF EXISTS technical_assistance;

CREATE DATABASE technical_assistance;

USE technical_assistance;


CREATE TABLE address
(
    code         bigint      NOT NULL PRIMARY KEY auto_increment,
    street       VARCHAR(60) NOT NULL,
    number       VARCHAR(10) NOT NULL,
    complement   VARCHAR(50),
    neighborhood VARCHAR(30) NOT NULL,
    city         VARCHAR(25) NOT NULL,
    STATE        VARCHAR(25) NOT NULL,
    zipcode      VARCHAR(9)  NOT NULL
);

CREATE TABLE customer
(
    code         bigint       NOT NULL PRIMARY KEY auto_increment,
    name         VARCHAR(100) NOT NULL,
    email        VARCHAR(100) NOT NULL,
    phone        VARCHAR(20)  NOT NULL,
    cpf          VARCHAR(14)  NOT NULL,
    address_code bigint       NOT NULL,

    FOREIGN KEY (address_code) REFERENCES address (code)
);

CREATE TABLE payment_method
(
    code bigint      NOT NULL PRIMARY KEY auto_increment,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE order_status
(
    code bigint      NOT NULL PRIMARY KEY auto_increment,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customer_order
(
    code                bigint         NOT NULL PRIMARY KEY auto_increment,
    description         VARCHAR(100)   NOT NULL,
    issue_date          DATE           NOT NULL,
    end_date            DATE           NOT NULL,
    price               DECIMAL(10, 2) NOT NULL,
    customer_code       bigint         NOT NULL,
    payment_method_code bigint         NOT NULL,
    status_code         bigint         NOT NULL,
    observation         VARCHAR(200),

    FOREIGN KEY (customer_code) REFERENCES customer (code),
    FOREIGN KEY (payment_method_code) REFERENCES payment_method (code),
    FOREIGN KEY (status_code) REFERENCES order_status (code)
);


SELECT *
FROM customer;
SELECT *
FROM address;
SELECT *
FROM order_status;
SELECT *
FROM customer_order;