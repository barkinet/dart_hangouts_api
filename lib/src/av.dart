part of hangouts_api;

class HangoutAv {
  ManyEventHandler _onCameraMute;
  ManyEventHandler get onCameraMute => _onCameraMute;
  
  HangoutAvEffects _effects;
  HangoutAvEffects get effects => _effects;
  
  HangoutAv._internal() {
    _onCameraMute = new ManyEventHandler._internal(["av", "onCameraMute"], HangoutEvent.CAMERA_MUTE_EVENT);
  }
}

class CameraMuteEvent implements HangoutEvent {
  bool isCameraMute;
  CameraMuteEvent._internal(js.Proxy data) {
    isCameraMute = data.isCameraMute;
    js.release(data);
  }
}
