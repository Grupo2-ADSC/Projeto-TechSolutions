DROP DATABASE if exists TechSolutions;
CREATE DATABASE if not exists TechSolutions;
USE TechSolutions;

CREATE TABLE endereco (
 idEndereco INT PRIMARY KEY auto_increment,
 CEP CHAR(8) not null,
 logradouro VARCHAR(130) not null,
 numero VARCHAR(12) not null,
 complemento VARCHAR(45),
 bairo VARCHAR(45) not null,
 cidade VARCHAR(45) not null,
 estado CHAR(2) not null,
 tipo char(7),
 constraint chk check (tipo in('Empresa','Armazem'))
 )auto_increment = 100;
 
 INSERT INTO endereco VALUES 
 (null, '08230769', 'Rua João Mendes', 1245, 'B', 'Campo Limpo', 'São Paulo', 'SP', 'Empresa'), 
 (null, '07830650', 'Avenida Francisco Pessoa', 25, null, 'Brasilandia', 'São Paulo', 'SP', 'Empresa'),
 (null, '12345678', 'Rua da Liberdade', 1245, 'B', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (null, '87654321', 'Rua Almada', 1245, 'B', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem'), 
 (null, '43218765', 'Rua Mimo de Vênus', 1245, 'B', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (null, '12341234', 'Rua flor de Abril', 1245, 'B', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' );

CREATE TABLE empresa (
idEmpresa INT primary key auto_increment,
cnpj CHAR(14) UNIQUE not null,
nome VARCHAR(100) not null,
telefone CHAR(11) default 'sem numero',
email VARCHAR(90) not null,
senha VARCHAR(50) not null,
fkEndereco INT, 
foreign key (fkEndereco) references endereco(idEndereco)
);

 INSERT INTO empresa VALUES
(null, '05483257694125', 'pilao', '11999267541', 'pilao_saopaulo@pilao.com.br', 'Bananinha123', null),
(null, '63310411001094', '3coracoes', '1138060020', '3coracoes_ceara@3coracoes.com.br', 'Manga123', null);

select * from empresa;

UPDATE empresa SET fkEndereco = 100 WHERE idEmpresa = 1;
UPDATE empresa SET fkEndereco = 101 WHERE idEmpresa = 2;
 
 CREATE TABLE funcionario (
 idFuncionario INT auto_increment,
 nome VARCHAR(45) not null,
 sobrenome VARCHAR(90) not null,
 cargo VARCHAR(45),
 email VARCHAR(90) not null,
 senha VARCHAR(50) not null,
 fkEmpresa INT, 
 foreign key (fkEmpresa) references empresa(idEmpresa),
 PRIMARY KEY (idFuncionario, fkEmpresa)
);

INSERT INTO funcionario (nome, sobrenome, cargo, email, senha, idFuncionario, fkEmpresa) VALUES
('Pedro','Santos','Gerente de operações','Pedro@gmail.com','Bananinha123', 1, 1),
('Rafael','Carmona','Auxiliar de operações','Rafael@gmail.com','Uva123', 1, 2),
('Yago','Martins','Supervisor de operações','Yago@gmail.com','Maçã123', 2, 2);

CREATE TABLE armazem (
idArmazem INT PRIMARY KEY auto_increment,
numero VARCHAR(50),
areaArmazem decimal(4,3),
fkEmpresa INT, 
foreign key (fkEmpresa) references empresa(idEmpresa),
fkEndereco INT, 
foreign key (fkEndereco) references endereco(idEndereco)
);

INSERT INTO armazem VALUES 
(null, 11, 2.000, 1, 102),
(null, 13, 5.000, 1, 103),
(null, 24, 7.000, 2, 104),
(null, 27, 9.000, 2, 105);

select * from armazem;

select * from endereco;

CREATE TABLE sensor (
idSensor INT auto_increment,
modelo_sensor VARCHAR(100),
fkArmazem INT, 
CONSTRAINT fkA foreign key (fkArmazem) references armazem(idArmazem),
PRIMARY KEY (idSensor, fkArmazem)
) auto_increment = 40; 

INSERT INTO sensor VALUES
(40, 'DHT11', 1),
(41, 'DHT11', 2),
(42, 'DHT11', 3),
(43, 'DHT11', 3);


CREATE TABLE registro (
idRegistro INT auto_increment,
dataRegistro DATETIME default current_timestamp,
umidadeRegistro INT,
fkSensor INT, 
CONSTRAINT fkS foreign key (fkSensor) references sensor(idSensor),
primary key (idRegistro, fkSensor)
)auto_increment = 30;

INSERT INTO registro (umidadeRegistro, idRegistro, fkSensor) VALUES 
(30, 12, 40),
(31, 25, 41),
(32, 18, 42),
(33, 40, 42);

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


