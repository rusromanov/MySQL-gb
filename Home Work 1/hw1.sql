/*
 1.Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf,
 задав в нем логин и пароль, который указывался при установке.

 Cделал, скрин в репозитории.
 */

/* 
 2.Создайте базу данных example, разместите в ней таблицу users, 
 состоящую из двух столбцов, числового id и строкового name 
*/
CREATE DATABASE example;
USE example;

CREATE TABLE users (
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
name VARCHAR(50) UNIQUE);

/*
 3.Создайте дамп базы данных example из предыдущего задания, 
 разверните содержимое дампа в новую базу данных sample.*/

CREATE DATABASE sample;
/*
mysqldump example > example.sql
mysql sample < example.sql
*/