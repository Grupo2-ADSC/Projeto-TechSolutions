create database if not exists metricas;

use metricas;

create table if not exists sensores (
id int PRIMARY KEY AUTO_INCREMENT,
dtHora DATETIME default current_timestamp NOT NULL,
dht11_umidade float,
dht11_temperatura float,
luminosidade float,
lm35_temperatura float,
chave int
);

SELECT * FROM sensores;

