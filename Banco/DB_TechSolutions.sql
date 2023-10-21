DROP DATABASE IF EXISTS TechSolutions;

CREATE DATABASE IF NOT EXISTS TechSolutions;

USE TechSolutions;

CREATE TABLE endereco (
 idEndereco INT PRIMARY KEY AUTO_INCREMENT,
 CEP CHAR(8) NOT NULL,
 logradouro VARCHAR(130) NOT NULL,
 numero VARCHAR(12) NOT NULL,
 complemento VARCHAR(100) DEFAULT 'Sem endereço',
 bairo VARCHAR(45) NOT NULL,
 cidade VARCHAR(45) NOT NULL,
 estado CHAR(2) NOT NULL,
 tipo CHAR(7),
 CONSTRAINT chk CHECK (tipo IN('Empresa','Armazem'))
 )AUTO_INCREMENT = 100;
 
 INSERT INTO endereco VALUES 
 (NULL, '09260290', 'Rua João Mendes', 1245, NULL, 'Campo Limpo', 'São Paulo', 'SP', 'Empresa'), 
 (NULL, '07830650', 'Avenida Francisco Pessoa', 25, NULL, 'BrASilandia', 'São Paulo', 'SP', 'Empresa'),
 (NULL, '12345678', 'Rua da Liberdade', 1245, NULL, 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (NULL, '87654321', 'Rua Almada', 1245, 'Ao lado do posto ipiranga', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem'), 
 (NULL, '43218765', 'Rua Mimo de Vênus', 1245, 'Ao lado do restaurante Vivano', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (NULL, '12341234', 'Rua flor de Abril', 1245, 'Muro azul', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' );

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) UNIQUE NOT NULL,
nome VARCHAR(100) NOT NULL,
telefone CHAR(11) DEFAULT 'Sem numero',
email VARCHAR(90) NOT NULL,
senha VARCHAR(50) NOT NULL,
fkEndereco INT, 
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

 INSERT INTO empresa VALUES
(NULL, '05483257694125', 'pilao', '11999267541', 'pilao_saopaulo@pilao.com.br', 'BananINha123', NULL),
(NULL, '63310411001094', '3coracoes', '1138060020', '3coracoes_ceara@3coracoes.com.br', 'Manga123', NULL);

SELECT * FROM empresa;

UPDATE empresa SET fkEndereco = 100 WHERE idEmpresa = 1;
UPDATE empresa SET fkEndereco = 101 WHERE idEmpresa = 2;
 
 CREATE TABLE funcionario (
 idFuncionario INT AUTO_INCREMENT,
 nome VARCHAR(45) NOT NULL,
 sobrenome VARCHAR(90) NOT NULL,
 cargo VARCHAR(45),
 email VARCHAR(90) NOT NULL,
 senha VARCHAR(50) NOT NULL,
 fkEmpresa INT, 
 FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
 PRIMARY KEY (idFuncionario, fkEmpresa)
);

INSERT INTO funcionario (nome, sobrenome, cargo, email, senha, idFuncionario, fkEmpresa) VALUES
('Pedro','Santos','Gerente de operações','Pedro@gmail.com','BananINha123', 1, 1),
('Rafael','Carmona','Auxiliar de operações','Rafael@gmail.com','Uva123', 1, 2),
('Yago','MartINs','Supervisor de operações','Yago@gmail.com','Maçã123', 2, 2);

CREATE TABLE armazem (
idArmazem INT PRIMARY KEY AUTO_INCREMENT,
numero VARCHAR(50),
areaArmazem decimal(4,3),
fkEmpresa INT, 
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
fkEndereco INT, 
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

INSERT INTO armazem VALUES 
(NULL, 11, 2.000, 1, 102),
(NULL, 13, 5.000, 1, 103),
(NULL, 24, 7.000, 2, 104),
(NULL, 27, 9.000, 2, 105);

SELECT * FROM armazem;

SELECT * FROM endereco;

CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT,
modelo_sensor VARCHAR(100),
fkArmazem INT, 
CONSTRAINT fkA FOREIGN KEY (fkArmazem) REFERENCES armazem(idArmazem),
PRIMARY KEY (idSensor, fkArmazem)
)AUTO_INCREMENT = 40; 

INSERT INTO sensor VALUES
(40, 'DHT11', 1),
(41, 'DHT11', 2),
(42, 'DHT11', 3),
(43, 'DHT11', 3);


CREATE TABLE registro (
idRegistro INT AUTO_INCREMENT,
dataRegistro datetime DEFAULT current_timestamp,
umidadeRegistro INT,
fkSensor INT, 
CONSTRAINT fkS FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
PRIMARY KEY (idRegistro, fkSensor)
)AUTO_INCREMENT = 30;

INSERT INTO registro (umidadeRegistro, idRegistro, fkSensor) VALUES 
(30, 12, 40),
(31, 25, 41),
(32, 18, 42),
(33, 40, 42);

SHOW TABLES;
SELECT * FROM empresa;
SELECT * FROM endereco;
SELECT * FROM funcionario;
SELECT * FROM armazem;
SELECT * FROM sensor;
SELECT * FROM registro;

SELECT * FROM empresa
JOIN endereco ON empresa.idEmpresa = endereco.fkEmpresa;

SELECT * FROM empresa
JOIN funcionario ON empresa.idEmpresa = funcionario.fkEmpresa;

SELECT empresa.nome AS 'Empresa', funcionario.nome, funcionario.sobrenome, funcionario.cargo FROM empresa
JOIN funcionario ON empresa.idEmpresa = funcionario.fkEmpresa;

SELECT * FROM empresa
JOIN armazem ON empresa.idEmpresa = armazem.fkEmpresa;

SELECT empresa.nome AS 'Empresa', armazem.* FROM empresa
JOIN armazem ON empresa.idEmpresa = armazem.fkEmpresa;

SELECT * FROM armazem
JOIN sensor ON armazem.idArmazem = sensor.fkArmazem;

SELECT armazem.idArmazem AS 'Armazem', sensor.idSensor, sensor.modelo_sensor FROM armazem
JOIN sensor ON armazem.idArmazem = sensor.fkArmazem;

SELECT * FROM sensor
JOIN registro ON sensor.idSensor = registro.fkSensor;

SELECT sensor.idSensor AS 'Sensor', registro.dataRegistro AS 'Data e Hora', registro.umidadeRegistro AS 'Umidade' FROM sensor
JOIN registro ON sensor.idSensor = registro.fkSensor;


