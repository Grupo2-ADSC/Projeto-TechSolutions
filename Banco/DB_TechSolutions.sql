DROP DATABASE if exists TechSolutions;
CREATE DATABASE if not exists TechSolutions;
USE TechSolutions;

CREATE TABLE empresa (
idEmpresa INT primary key auto_increment,
cnpj CHAR(14) UNIQUE not null,
nome VARCHAR(100) not null,
telefone CHAR(11) default 'sem numero',
email VARCHAR(90) not null,
senha VARCHAR(50) not null
);

INSERT INTO Empresa VALUES
(null, '05483257694125', 'pilao', '11999267541', 'pilao_saopaulo@pilao.com.br', 'Bananinha123'),
(null, '63310411001094', '3coracoes', '1138060020', '3coracoes_ceara@3coracoes.com.br', 'Manga123');

CREATE TABLE endereco (
 idEndereco INT PRIMARY KEY auto_increment,
 CEP CHAR(8) not null,
 logradouro VARCHAR(130) not null,
 numero int not null,
 complemento VARCHAR(45) default 'sem complemento',
 bairo VARCHAR(45) not null,
 cidade VARCHAR(45) not null,
 estado CHAR(2) not null,
 fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)
 fkArmazem INT,
 );
 
 INSERT INTO endereco VALUES 
 (null, '08230769','Rua João Mendes',1245,'B','Campo Limpo','São Paulo','SP', 1 ), 
 (null, '07830650','Avenida Francisco Pessoa',25,null,'Brasilandia','São Paulo','SP', 2);
 
 CREATE TABLE funcionario (
 idFuncionario INT PRIMARY KEY auto_increment,
 nome VARCHAR(45) not null,
 sobrenome VARCHAR(90) not null,
 cargo VARCHAR(45),
 email VARCHAR(90) not null,
 senha VARCHAR(50) not null,
 fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)
);
INSERT INTO funcionario VALUES
(null,'Pedro','Santos','Gerente de operações','Pedro@gmail.com','Bananinha123', 1),
(null,'Rafael','Carmona','Auxiliar de operações','Rafael@gmail.com','Uva123', 1),
(null,'Yago','Martins','Supervisor de operações','Yago@gmail.com','Maçã123', 2);

CREATE TABLE armazem (
idArmazem INT PRIMARY KEY auto_increment,
numero int,
areaArmazem VARCHAR(100),
fkEmpresa INT, foreign key (fkEmpresa) references empresa(idEmpresa)
);

INSERT INTO armazem VALUES 
(null,11,'MG',12, 1 ),
(null,13,'SP',35, 1),
(null,24,'RJ',27, 2),
(null,27,'RS',39, 2);


CREATE TABLE sensor (
idSensor INT PRIMARY KEY auto_increment,
modelo_sensor VARCHAR(100),
fkArmazem INT, CONSTRAINT fkA foreign key (fkArmazem) references armazem(idArmazem)
) auto_increment = 40; 

INSERT INTO sensor (modelo_sensor, fkArmazem) VALUES
('DHT11',1),
('LM35',1),
('DHT11',2),
('LM35',2);


CREATE TABLE registro (
idRegistro INT PRIMARY KEY auto_increment,
dataRegistro DATETIME default current_timestamp,
umidadeRegistro INT,
fkSensor INT, CONSTRAINT fkS foreign key (fkSensor) references sensor(idSensor)
)auto_increment = 30;

INSERT INTO registro (umidadeRegistro, fkSensor) VALUES 
('12', 40),
('25' ,40),
('18', 42),
('40', 42);

show tables;
select * from empresa;
select * from endereco;
select * from funcionario;
select * from armazem;
select * from sensor;
select * from registro;

SELECT * FROM empresa
JOIN endereco ON empresa.idEmpresa = endereco.fkEmpresa;

SELECT * FROM empresa
JOIN funcionario ON empresa.idEmpresa = funcionario.fkEmpresa;

SELECT empresa.nome as 'Empresa', funcionario.nome, funcionario.sobrenome, funcionario.cargo FROM empresa
JOIN funcionario ON empresa.idEmpresa = funcionario.fkEmpresa;

SELECT * FROM empresa
JOIN armazem ON empresa.idEmpresa = armazem.fkEmpresa;

SELECT empresa.nome as 'Empresa', armazem.* FROM empresa
JOIN armazem ON empresa.idEmpresa = armazem.fkEmpresa;

SELECT * FROM armazem
JOIN sensor ON armazem.idArmazem = sensor.fkArmazem;

SELECT armazem.idArmazem as 'Armazem', sensor.idSensor, sensor.modelo_sensor FROM armazem
JOIN sensor ON armazem.idArmazem = sensor.fkArmazem;

SELECT * FROM sensor
JOIN registro ON sensor.idSensor = registro.fkSensor;

SELECT sensor.idSensor as 'Sensor', registro.dataRegistro as 'Data e Hora', registro.umidadeRegistro as 'Umidade' FROM sensor
JOIN registro ON sensor.idSensor = registro.fkSensor;


