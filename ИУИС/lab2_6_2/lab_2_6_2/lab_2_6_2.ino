int per = 1000;
void setup() {
  Serial.begin(9600);
  pinMode(10,OUTPUT);
}
void loop() {
  if (Serial.available() > 0) {
    float freq = Serial.parseFloat();
    if (freq != 0) {
      Serial.print("Get freq: "); Serial.print(freq); Serial.print("Hz");
      per = (int)(1. / freq * 1000);
      Serial.print("; New per: "); Serial.print(per); Serial.println("ms");
    }
  }
  digitalWrite(10, HIGH);
  delay(per/2);
  digitalWrite(10,LOW);
  delay(per/2);
}
