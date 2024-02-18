void setup() {
  Serial.begin(9600);
  pinMode(10, OUTPUT);
}
void loop() {
  int val = analogRead(0);
  float res = (val/1000.0*255);
  Serial.print(val);
  Serial.print("  ");
  Serial.println(res);
  analogWrite(10, res);
  delay(1000);
}
