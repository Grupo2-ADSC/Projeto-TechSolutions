create database if not exists metricas;

use metricas;

create table if not exists sensores (
dht11_umidade float,
dht11_temperatura float,
luminosidade float,
lm35_temperatura float,
chave int
);

SELECT * FROM sensores;

