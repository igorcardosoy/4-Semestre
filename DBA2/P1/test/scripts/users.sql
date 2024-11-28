-- Usuário master do sistema
DROP USER AEROPORTO CASCADE;

CREATE USER AEROPORTO
IDENTIFIED BY AIRPORTPASS
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT MASTER TO AEROPORTO;