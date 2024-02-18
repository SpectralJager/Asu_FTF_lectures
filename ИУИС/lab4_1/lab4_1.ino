// программа измерения напряжения
#define MEASURE_PERIOD 500 // время периода измерения
#define R1 4.8 // сопротивление резистора R1
#define R2 14.1 // сопротивление резистора R2
uint32_t timer = 0; // переменная таймера
float u1; // измеренные напряжения
void setup() {
  Serial.begin(9600); // инициализируем порт, скорость 9600
}
void loop() {
  // период 500 мс
  if (millis() - timer >= MEASURE_PERIOD) { // таймер на millis()
    timer = millis(); // сброс
    u1= ((float)analogRead(A0)) * 5. / 1024. /R2 * (R1 + R2);
    // передача данных через последовательный порт
    Serial.print("U1 = "); Serial.println(u1, 2);
  }
}
