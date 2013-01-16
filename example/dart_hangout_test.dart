import "dart:html";
import "dart:json";
import "package:hangouts_api/hangouts_api.dart";

var hapi;
var outputDiv;
var counter;

void output(str, [bool replace = false]) {
  if (replace) outputDiv.text = "";
  outputDiv.appendHtml("$str<br>");
}

void tests() {
  
  var video = hapi.layout.getVideoCanvas();
  
  video.setPosition({"left": 200, "top": 200});
  
  query("#button1").on.click.add((event) {
    hapi.layout.getVideoCanvas().setVisible(!hapi.layout.getVideoCanvas().isVisible());
  });

  query("#button2").on.click.add((event) {
    hapi.layout.getVideoCanvas().setPosition(200, 200);
  });
  
  query("#button3").on.click.add((event) {
    Map position = hapi.layout.getVideoCanvas().getPosition();
    position["left"] = position["left"] + 10; 
    position["top"] = position["top"] + 10;
    hapi.layout.getVideoCanvas().setPosition(position);
  });

  query("#button4").on.click.add((event) {
    hapi.layout.getVideoCanvas().setVideoFeed(hapi.layout.getDefaultVideoFeed());
  });
  
  query("#button5").on.click.add((event) {
    hapi.layout.getVideoCanvas().setVideoFeed(hapi.layout.createParticipantVideoFeed(hapi.getLocalParticipantId()));
  });

}

void main() {
  hapi = new Hangout();
  outputDiv = query("#text");
  outputDiv.text = "";
  counter = 0;
  
  hapi.onApiReady.add((ApiReadyEvent event) {
    if (event.isApiReady) {
      window.setTimeout(tests, 1);
    }
  });
}



