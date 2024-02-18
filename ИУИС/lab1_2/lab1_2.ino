int led = 10;
int btn = 2;

void setup() {
  pinMode(led, OUTPUT);
  pinMode(btn, INPUT);
}
void task2() {
  if (digitalRead(btn) == HIGH) {
  digitalWrite(led, HIGH);
  } else {
  digitalWrite(led, LOW);
  }
}
void loop() {
  task2();
}
