DROP DATABASE IF EXISTS TechSolutions;

CREATE DATABASE IF NOT EXISTS TechSolutions;

USE TechSolutions;

CREATE TABLE endereco (
 idEndereco INT PRIMARY KEY AUTO_INCREMENT,
 CEP CHAR(9) NOT NULL,
 logradouro VARCHAR(50) NOT NULL,
 numero INT NOT NULL,
 complemento VARCHAR(100) DEFAULT 'Sem endereço',
 bairro VARCHAR(50) NOT NULL,
 cidade VARCHAR(50) NOT NULL,
 estado CHAR(2) NOT NULL,
 tipo CHAR(7),
 CONSTRAINT chk CHECK (tipo IN('Empresa','Armazém'))
 )AUTO_INCREMENT = 100;
 
 INSERT INTO endereco VALUES 
 (NULL, '09260-290', 'Rua Conceição', 1245, NULL, 'Campo Limpo', 'São Paulo', 'SP', 'Empresa'), 
 (NULL, '09275-420', 'Avenida Francisco Pessoa', 25, NULL, 'Brasilandia', 'Santo André', 'SP', 'Empresa'),
 (NULL, '09260-420', 'Avenida dos Estados', 2540, NULL, 'Alzira Franco', 'São Paulo', 'SP', 'Empresa'),
 (NULL, '03340-390', 'Rua da Liberdade', 190, NULL, 'Jardim Santo Alberto', 'São Bernardo do Campo', 'SP', 'Armazém' ), 
 (NULL, '08310-220', 'Rua Almada', 31, 'Ao lado do posto ipiranga', 'Parque das Nações', 'São Paulo', 'SP', 'Armazém'), 
 (NULL, '04270-190', 'Avenida Mimo de Vênus', 147, 'Ao lado do Mercado Rossi', 'Assunçao', 'São Bernardo do Campo', 'SP', 'Armazém' ), 
 (NULL, '06270-210', 'Avenida flor de Abril', 19, 'Muro azul', 'Jardim Ana Maria', 'São Caetano do Sul', 'SP', 'Armazém' );
 
 select idEndereco from endereco where cep = '09260-290' and logradouro = 'Rua Conceição' and numero = 1245;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14) UNIQUE NOT NULL,
nome VARCHAR(50) NOT NULL,
telefone CHAR(14) DEFAULT 'Sem numero',
email VARCHAR(100) NOT NULL,
senha VARCHAR(16) NOT NULL,
fkEndereco INT, 
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

 INSERT INTO empresa VALUES
(NULL, '05483257000125', 'Pilão', '11999267541', 'pilao@cafebrasil.com.br', 'pil4o123', 100),
(NULL, '01340569000140', 'Café Pelé', '11999267541', 'cafepele@brasil.com.br', 'C4f3pele', 101),
(NULL, '63310411000194', '3corações', '1138060020', '3coracoes@cafe.com.br', '3cor4co3s', 102);

SELECT * FROM empresa;
SELECT * FROM ENDERECO;

/*UPDATE empresa SET fkEndereco = 100 WHERE idEmpresa = 1;
UPDATE empresa SET fkEndereco = 101 WHERE idEmpresa = 2;*/
 
 CREATE TABLE funcionario (
 idFuncionario INT AUTO_INCREMENT,
 nome VARCHAR(50) NOT NULL,
 sobrenome VARCHAR(50) NOT NULL,
 cargo VARCHAR(50),
 email VARCHAR(100) NOT NULL,
 senha VARCHAR(16) NOT NULL,
 fkEmpresa INT, 
 FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
 PRIMARY KEY (idFuncionario, fkEmpresa)
);

INSERT INTO funcionario (nome, sobrenome, cargo, email, senha, idFuncionario, fkEmpresa) VALUES
('Pedro','Santos','Gerente de operações','Pedro@gmail.com','12345678', 1, 1),
('Rafael','Carmona','Auxiliar de operações','Rafael@gmail.com','87654321', 2, 1),
('Gabriel','Silva','Analista','Gabriel@gmail.com','G4br!3l', 3, 2),
('Yago','Martins','Supervisor de operações','Yago@gmail.com','Y4go123', 4, 3),
('Marcus','Souza','Analista','Marcus@gmail.com','M4rcu5', 5, 3);


CREATE TABLE armazem (
idArmazem INT PRIMARY KEY AUTO_INCREMENT,
numero INT,
areaArmazem DECIMAL(5,3),
fkEmpresa INT, 
FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
fkEndereco INT, 
FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco)
);

INSERT INTO armazem VALUES 
(NULL, 1, 2.000, 1, 103),
(NULL, 3, 5.000, 2, 104),
(NULL, 7, 7.000, 3, 105),
(NULL, 11, 9.000, 3, 106);

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
JOIN endereco ON empresa.fkendereco = endereco.idEndereco;

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