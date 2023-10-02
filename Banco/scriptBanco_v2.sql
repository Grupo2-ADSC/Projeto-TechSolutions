DROP DATABASE if exists TechSolutions;
CREATE DATABASE if not exists TechSolutions;
USE TechSolutions;

CREATE TABLE empresa (
idEmpresa INT primary key auto_increment,
cnpj CHAR(14) UNIQUE not null,
nome VARCHAR(100) not null,
telefone CHAR(11) default 'sem numero',
email VARCHAR(90) default 'sem e-mail',
senha VARCHAR(50) not null
);

CREATE TABLE endereco (
 idEndereco INT PRIMARY KEY auto_increment,
 CEP CHAR(8) not null,
 logradouro VARCHAR(130) not null,
 numero VARCHAR(12) not null,
 tipo_local VARCHAR(20),
 complemento VARCHAR(250),
 bairo VARCHAR(45) not null,
 cidade VARCHAR(45) not null,
 estado CHAR(2) not null,
 fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)
 );
 
 
 CREATE TABLE funcionario (
 idFuncionario INT PRIMARY KEY auto_increment,
 email VARCHAR(90) not null,
 senha VARCHAR(50) not null,
 nome VARCHAR(45) not null,
 sobrenome VARCHAR(90) not null,
 cargo VARCHAR(45),
 fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)
);

CREATE TABLE armazem (
idArmazem INT PRIMARY KEY auto_increment,
numero VARCHAR(50),
localidade VARCHAR(50),
areaArmazem VARCHAR(100),
fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)

);
CREATE TABLE sensor (
idSensor INT PRIMARY KEY auto_increment,
modelo_sensor VARCHAR(100),
fkArmazem INT, CONSTRAINT fkA foreign key (fkArmazem) references armazem(idArmazem)
) auto_increment = 40;

CREATE TABLE registro (
idRegistro INT PRIMARY KEY auto_increment,
dataRegistro DATETIME,
umidadeRegistro INT,
fkSensor INT, CONSTRAINT fkS foreign key (fkSensor) references sensor(idSensor)
)auto_increment = 30;


 
 




