CREATE DATABASE university;
CREATE USER 'university'@'%' IDENTIFIED BY 'university';

GRANT ALL PRIVILEGES ON university.* TO 'university'@'%';

SHOW GRANTS FOR 'university'@'%';
