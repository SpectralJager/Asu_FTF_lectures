char mode = '0';
void setup() {
  Serial.begin(9600);
  pinMode(10,OUTPUT);
}
void loop() {
  if (Serial.available() > 0) {
    char tmp = Serial.read();
    if (tmp == '0' || tmp == '1' || tmp == '2') {
      mode = tmp;
      Serial.print("selected mode: ");
      Serial.println(mode);
    }
  }
  if (mode == '0') {
    digitalWrite(10, HIGH);
    delay(1000);
    digitalWrite(10, LOW);
    delay(1000);
  } else if (mode == '1') {
    digitalWrite(10, HIGH);
    delay(750);
    digitalWrite(10, LOW);
    delay(100);
    digitalWrite(10, HIGH);
    delay(100);
    digitalWrite(10, LOW);
    delay(100);
    digitalWrite(10, HIGH);
    delay(100);
    digitalWrite(10, LOW);
    delay(750);
  } else if (mode == '2') {
    digitalWrite(10, HIGH);
  }
}
