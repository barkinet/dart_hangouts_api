import "dart:html";
import "dart:json";
import "package:hangouts_api/hangouts_api.dart";

var hapi;
var outputDiv;

void output(str, [bool replace = false]) {
  if (replace) outputDiv.text = "";
  outputDiv.appendHtml("$str<br><br>");
}

void tests() {
  
  hapi.data.onStateChanged.add((StateChangedEvent e) {
    output(JSON.stringify(e.addedKeys), true);
    output(JSON.stringify(e.removedKeys));
    output(JSON.stringify(e.metadata));
    output(JSON.stringify(e.state));
  });
  
  hapi.onParticipantsChanged.add((ParticipantsChangedEvent e) {
    output("", true);
    e.participants.forEach((p) {
      output(p.person.displayName);
    });
  });

  query("#button1").on.click.add((event) {
    hapi.data.submitDelta({"lastUpdate": hapi.getLocalParticipant().person.displayName}, []);
  });
  
  query("#button5").on.click.add((event) {
    hapi.layout.getVideoCanvas().setPosition(200, 200);
    hapi.layout.getVideoCanvas().setVisible(!hapi.layout.getVideoCanvas().isVisible());
  });

}

void main() {
  hapi = new Hangout();
  outputDiv = query("#text");
  outputDiv.text = "";
  
  hapi.onApiReady.add((ApiReadyEvent event) {
    if (event.isApiReady) {
      window.setTimeout(tests, 1);
    }
  });
}



