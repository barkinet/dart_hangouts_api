import "dart:html";
import "package:hangouts_api/hangouts_api.dart";

void main() {
  var hapi = new Hangout();
  var outputDiv = query("#text");
  outputDiv.text = "";
  
  void output(str) {
    outputDiv.appendHtml(" / $str");
  }
  
  hapi.onApiReady.add((ApiReadyEvent event) {
    if (event.isApiReady) {
      window.setTimeout(() {
        var participants = hapi.getEnabledParticipants();
        participants.forEach((p) => output("${p.person.id} ${p.person.displayName}"));
      }, 1);
    }
  });
}



