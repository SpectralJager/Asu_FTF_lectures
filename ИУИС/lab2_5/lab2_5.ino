char val = '0';
void setup() {
  Serial.begin(9600);
  pinMode(10, OUTPUT);
}
void loop() {
  if (Serial.available() > 0) {
    char tmp = Serial.read();
    if (tmp == '1' || tmp == '0') {
      val = tmp;
      Serial.print("recive:");
      Serial.println(val);
    }  
  }
  if (val=='1') {
    digitalWrite(10,HIGH); delay (100);
    digitalWrite(10,LOW); delay (100);
  }
  if (val=='0') {
    digitalWrite(10,HIGH); delay (500);
    digitalWrite(10,LOW); delay (500);
  }
}
