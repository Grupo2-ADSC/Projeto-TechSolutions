create database metricas;

use metricas;

create table sensores (
dht11_umidade float,
dht11_temperatura float,
luminosidade float,
lm35_temperatura float,
chave int,
dtHora datetime default current_timestamp
);

select * from sensores;



