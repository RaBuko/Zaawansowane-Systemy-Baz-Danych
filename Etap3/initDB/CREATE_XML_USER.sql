
CREATE USER c##test2 IDENTIFIED BY password1 CONTAINER=ALL; 

GRANT CREATE SESSION TO c##test2 CONTAINER=ALL;

GRANT ALL PRIVILEGES TO c##test2;