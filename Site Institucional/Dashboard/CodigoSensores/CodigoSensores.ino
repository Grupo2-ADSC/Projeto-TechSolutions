// Biliotecas
#include <DHT.h>
#include <Adafruit_Sensor.h>

#define DHTPIN A1
#define LM35PIN A5
#define LUMIPIN A0
#define CHAVPIN  7

DHT dht(DHTPIN, DHT11);

void setup() {
  // Definição de entradas
  pinMode(DHTPIN, INPUT);
  pinMode(LM35PIN, INPUT); 
  pinMode(LUMIPIN, INPUT);
  pinMode(CHAVPIN, INPUT);
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  float umidadeDHT11 = dht.readHumidity();
  float temperaturaDHT11 = dht.readTemperature();
  Serial.print(umidadeDHT11);
  Serial.print(";");
  Serial.print(temperaturaDHT11);
  Serial.print(";");
  
  // Ler valor do sensor LM35 (codigo da prof estava sem)
  const int temp_lm = analogRead(LM35PIN);
  
  // Convertendo a leitura analógica para temperatura em graus Celsius
  float temperaturaLM = (temp_lm)*5/(1023)/0.01; //float temperaturaLM= (temp_LM / 1024.0) * 500.0;
  Serial.print(temperaturaLM);
  Serial.print(";");
  
  // Ler valores do LUMI
  float luminosidade = analogRead(LUMIPIN);
  Serial.print(luminosidade);
  Serial.print(";");
}
