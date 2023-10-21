drop database if exists TechSolutions;
create database if not exists TechSolutions;
use TechSolutions;

create table endereco (
 idEndereco int primary key auto_increment,
 CEP char(8) not null,
 logradouro varchar(130) not null,
 numero varchar(12) not null,
 complemento varchar(100) default 'Sem endereço',
 bairo varchar(45) not null,
 cidade varchar(45) not null,
 estado char(2) not null,
 tipo char(7),
 constraint chk check (tipo in('Empresa','Armazem'))
 )auto_increment = 100;
 
 insert into endereco values 
 (null, '08230769', 'Rua João Mendes', 1245, null, 'Campo Limpo', 'São Paulo', 'SP', 'Empresa'), 
 (null, '07830650', 'Avenida Francisco Pessoa', 25, null, 'Brasilandia', 'São Paulo', 'SP', 'Empresa'),
 (null, '12345678', 'Rua da Liberdade', 1245, null, 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (null, '87654321', 'Rua Almada', 1245, 'Ao lado do posto ipiranga', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem'), 
 (null, '43218765', 'Rua Mimo de Vênus', 1245, 'Ao lado do restaurante Vivano', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' ), 
 (null, '12341234', 'Rua flor de Abril', 1245, 'Muro azul', 'Campo Limpo', 'São Paulo', 'SP', 'Armazem' );

create table empresa (
idEmpresa int primary key auto_increment,
cnpj char(14) unique not null,
nome varchar(100) not null,
telefone char(11) default 'Sem numero',
email varchar(90) not null,
senha varchar(50) not null,
fkEndereco int, 
foreign key (fkEndereco) references endereco(idEndereco)
);

 insert into empresa values
(null, '05483257694125', 'pilao', '11999267541', 'pilao_saopaulo@pilao.com.br', 'Bananinha123', null),
(null, '63310411001094', '3coracoes', '1138060020', '3coracoes_ceara@3coracoes.com.br', 'Manga123', null);

select * from empresa;

update empresa set fkEndereco = 100 where idEmpresa = 1;
update empresa set fkEndereco = 101 where idEmpresa = 2;
 
 create table funcionario (
 idFuncionario int auto_increment,
 nome varchar(45) not null,
 sobrenome varchar(90) not null,
 cargo varchar(45),
 email varchar(90) not null,
 senha varchar(50) not null,
 fkEmpresa int, 
 foreign key (fkEmpresa) references empresa(idEmpresa),
 primary key (idFuncionario, fkEmpresa)
);

insert into funcionario (nome, sobrenome, cargo, email, senha, idFuncionario, fkEmpresa) values
('Pedro','Santos','Gerente de operações','Pedro@gmail.com','Bananinha123', 1, 1),
('Rafael','Carmona','Auxiliar de operações','Rafael@gmail.com','Uva123', 1, 2),
('Yago','Martins','Supervisor de operações','Yago@gmail.com','Maçã123', 2, 2);

create table armazem (
idArmazem int primary key auto_increment,
numero varchar(50),
areaArmazem decimal(4,3),
fkEmpresa int, 
foreign key (fkEmpresa) references empresa(idEmpresa),
fkEndereco INT, 
foreign key (fkEndereco) references endereco(idEndereco)
);

insert into armazem values 
(null, 11, 2.000, 1, 102),
(null, 13, 5.000, 1, 103),
(null, 24, 7.000, 2, 104),
(null, 27, 9.000, 2, 105);

select * from armazem;

select * from endereco;

create table sensor (
idSensor int auto_increment,
modelo_sensor varchar(100),
fkArmazem int, 
constraint fkA foreign key (fkArmazem) references armazem(idArmazem),
primary key (idSensor, fkArmazem)
) auto_increment = 40; 

insert into sensor values
(40, 'DHT11', 1),
(41, 'DHT11', 2),
(42, 'DHT11', 3),
(43, 'DHT11', 3);


create table registro (
idRegistro int auto_increment,
dataRegistro datetime default current_timestamp,
umidadeRegistro int,
fkSensor int, 
constraint fkS foreign key (fkSensor) references sensor(idSensor),
primary key (idRegistro, fkSensor)
)auto_increment = 30;

insert into registro (umidadeRegistro, idRegistro, fkSensor) values 
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


