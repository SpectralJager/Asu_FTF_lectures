// программа измерения напряжения
#define MEASURE_PERIOD 500 // время периода измерения
#define R1 4.7 // сопротивление резистора R1
#define R2 1 // сопротивление резистора R2
uint32_t timer = 0; // переменная таймера
float u1; // измеренные напряжения
void setup() {
  Serial.begin(9600); // инициализируем порт, скорость 9600
}
void loop() {
  u1= (float)analogRead(0) * 5 * ((R1 + R2) / R2) / 1024;
  Serial.print("U1 = "); Serial.println(u1, 2);
  delay(500);
}
