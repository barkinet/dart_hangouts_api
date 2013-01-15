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
        hapi.av.onVolumesChanged.add((VolumesChangedEvent event) {
          print(JSON.stringify(event.volumes));
        });
      }, 1);
    }
  });
}



