#include <ESP8266WiFi.h>

int LED_1 = 2;
int LED_2 = 0;
int LED_3 = 4;

WiFiServer server(80);
String request = "";

void setup()
{
  Serial.begin(115200);
  Serial.println();
  ESP.eraseConfig();
  delay(500);

  Serial.print("Setting LED pins...");
  pinMode(LED_1, OUTPUT);
  pinMode(LED_2, OUTPUT);
  pinMode(LED_3, OUTPUT);

  Serial.print("Setting soft-AP...");
  boolean result = WiFi.softAP("LEDcontrol", "ledcontrol");
  if(result == true) {
    Serial.println("WIFI Ready");
    Serial.print("Soft-AP IP address = ");
    Serial.println(WiFi.softAPIP());
    server.begin();
  }
  else {
    Serial.println("WIFI start Failed!");
  }
}

void loop()
{
  Serial.printf("Stations connected = %d\n", WiFi.softAPgetStationNum());
  WiFiClient client = server.available(); //select client
  if (!client)  {  
    delay(300);
    return;
  } // if noone is connected -> return
  request = client.readStringUntil('\n'); //we only need first line
  Serial.println(request);
  if       ( request.indexOf("LED1ON") > 0 )  { digitalWrite(LED_1, HIGH);  }
  else if  ( request.indexOf("LED1OFF") > 0 ) { digitalWrite(LED_1, LOW);   }
  else if  ( request.indexOf("LED2ON") > 0 )  { digitalWrite(LED_2, HIGH);  }
  else if  ( request.indexOf("LED2OFF") > 0 ) { digitalWrite(LED_2, LOW);   }
  else if  ( request.indexOf("LED3ON") > 0 )  { digitalWrite(LED_3, HIGH);  }
  else if  ( request.indexOf("LED3OFF") > 0 ) { digitalWrite(LED_3, LOW);   }
  else if (request.indexOf("SEQUENCE") > 0 ){
    int i = 0;
      while(i < 6) {
        digitalWrite(LED_3, HIGH);
        digitalWrite(LED_2, HIGH);
        digitalWrite(LED_1, HIGH);
        
        delay(500);
        
        digitalWrite(LED_3, LOW);
        digitalWrite(LED_2, LOW);
        digitalWrite(LED_1, LOW);
        
        delay(500);
        i = i+1;
      }
      i = 0;
    }
  client.println("HTTP/1.1 204 No Content\r\n\r\n\0");
  client.flush();
}
