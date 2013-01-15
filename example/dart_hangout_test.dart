import "dart:html";
import "dart:json";
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
        output(JSON.stringify(hapi.av.getVolumes()));
        hapi.av.setCameraMute(true);
        hapi.av.setParticipantAudioLevel(hapi.getLocalParticipantId(), [0.1, 3]);
        output(JSON.stringify(hapi.av.getParticipantAudioLevel(hapi.getLocalParticipantId())));
        hapi.av.onCameraMute.add((CameraMuteEvent e) {
          output(e.isCameraMute);
        });
      }, 1);
    }
  });
}



