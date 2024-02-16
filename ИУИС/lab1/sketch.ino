int led = 10;
int btn = 2;

void setup() {
  pinMode(led, OUTPUT);
  pinMode(btn, INPUT);
}

void task1() {
  digitalWrite(led, HIGH);
  delay(1800);
  digitalWrite(led, LOW);
  delay(900);
}

void task2() {
  if (digitalRead(btn) == HIGH) {
    digitalWrite(led, HIGH);
  } else {
    digitalWrite(led, LOW);
  }
}

void task3() {
  if (digitalRead(btn) == HIGH) {
    task1();
  } 
}

void loop() {
  task2();
}
