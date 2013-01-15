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
      output("API Ready!");
      output(hapi.getHangoutId());
      output(hapi.getHangoutUrl());
      output(hapi.isAppVisible());
      hapi.onAppVisible.add((AppVisibleEvent event) {
        output("App visible: ${event.isAppVisible}");
      });
      hapi.av.onCameraMute.add((CameraMuteEvent event) {
        output("Camera muted: ${event.isCameraMute}");
      });
      hapi.hideApp();
    }
  });
}



