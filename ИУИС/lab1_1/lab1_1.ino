int led = 10;
void setup() {
  pinMode(led, OUTPUT);
}
void task1() {
  digitalWrite(led, HIGH);
  delay(1800);
  digitalWrite(led, LOW);
  delay(900);
}
void loop() {
  task1();
}
