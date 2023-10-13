create database metricas;

use metricas;

create table sensores (
idMetricas int primary key auto_increment,
dht11_umidade float,
dht11_temperatura float,
luminosidade float,
lm35_temperatura float,
chave int
);

select * from sensores;



