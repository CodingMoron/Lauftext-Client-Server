/**
 * Author: Luk Poncet lukas.poncet@gmx.ch
 */

import hypermedia.net.*;
import java.util.PriorityQueue;

UDP server;
PriorityQueue<String> receivedMessages;

PFont font;
int textX, textY;
String textDisplay;

void setup() {
  //size(1024, 600);
  fullScreen();
  pixelDensity(displayDensity());
  background(255);

  font = createFont("Arial", 84, true);
  textFont(font);

  textX = width;
  textY = height / 2;

  //Hier die IP allenfalls anpassen :-)
  server = new UDP(this, 49876, "127.0.0.1");
  server.listen(true);

  receivedMessages = new PriorityQueue<String>();
}


void draw() {
  if (textDisplay != null) {
    background(255);
    fill(0);
    text(textDisplay, textX, textY);
    textX -= 6;
  }

  if (textDisplay != null && textX < -textWidth(textDisplay)) {
    println("Filled:" + receivedMessages.size());
    textDisplay = receivedMessages.poll();
    textX = width;
  }
}


void receive(byte[] data, String HOST_IP, int PORT_RX) {
  String message = new String(data);
  if (message.length() >= 50) {
    message = message.substring(0, 50);
  }
  println(message);
  println(HOST_IP);
  
  //todo -> sperre
  if (receivedMessages.size() < 10) {
    receivedMessages.add(message);
  }
  
  server.send(Integer.toString(receivedMessages.size()), HOST_IP, PORT_RX);
  
  if (textDisplay == null) {
    textDisplay = receivedMessages.poll();
  }
}