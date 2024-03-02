int val = 0;
void setup() {
  Serial.begin(9600);
  pinMode(8, OUTPUT);
}
void loop() {
  if (Serial.available() > 0) {
    val = Serial.read();
    if (val=='H') {
      digitalWrite(10,HIGH);
      Serial.println("status: HIGH");
    }
    if (val=='L') {
      digitalWrite(10,LOW);
      Serial.println("status: LOW");
    }
  }
}
