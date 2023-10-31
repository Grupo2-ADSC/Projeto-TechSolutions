#include "DHT.h"
#define dht_type DHT11 
int dht_pin = A1;
DHT dht_1 = DHT(dht_pin, dht_type);

void setup()
{
  Serial.begin(9600);
  dht_1.begin();
}

void loop()
{
  float umidade = dht_1.readHumidity();
  if (isnan(umidade))
  {
    Serial.println("Erro ao ler o DHT");
  }
  else
  {
    Serial.println(umidade);
  }  
  delay(500);
}
