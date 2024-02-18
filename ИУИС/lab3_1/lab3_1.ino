void setup() {
  pinMode(10, OUTPUT);
}

void loop() {
  for (int value = 0; value < 100; value=value + 5) {
    analogWrite(10, value);
    delay(100);
  }
}
