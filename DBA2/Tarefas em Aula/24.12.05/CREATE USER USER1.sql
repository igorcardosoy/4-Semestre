CREATE USER USER1
IDENTIFIED BY 123
DEFAULT TABLESPACE USERS 
QUOTA 5M ON USERS 
TEMPORARY TABLESPACE TEMP; 

GRANT CREATE SESSION, CREATE TABLE		
TO USER1; 

GRANT SELECT 
ON HR.EMPLOYEES
TO USER1;


SELECT XID, STATUS, START_TIME FROM V$TRANSACTION;