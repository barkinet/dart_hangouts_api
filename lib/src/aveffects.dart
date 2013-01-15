part of hangouts_api;

/// Provides ability to add sound effects and attach image overlays to faces.
class HangoutAvEffects {
  
  ManyEventHandler _onFaceTrackingDataChanged;
  
  /// Handles callbacks to be called when the local participant starts or stops sending video.
  ManyEventHandler get onFaceTrackingDataChanged => _onFaceTrackingDataChanged;
  
  HangoutAvEffects._internal() {
    _onFaceTrackingDataChanged = new ManyEventHandler._internal(["av", "effects", "onFaceTrackingDataChanged"], HangoutEvent.FACE_TRACKING_DATA);
  }
}

class AudioResource extends ProxyObject {
  OnceEventHandler _onLoad;
  
  OnceEventHandler get onLoad => _onLoad;
  
  AudioResource._internal(js.Proxy proxy) : super._internal(proxy) {
    _onLoad = new OnceEventHandler._internalProxy(_proxy, HangoutEvent.RESOURCE_LOAD_RESULT);
  }
}

class FaceTrackingData extends HangoutEvent {
  /// Indicates whether the local participant's camera is activated.
  bool hasFace;
  Position leftEye;
  Position leftEyebrowLeft;
  Position leftEyebrowRight;
  Position lowerLip;
  Position mouthCenter;
  Position mouthLeft;
  Position mouthRight;
  Position noseRoot;
  Position noseTip;
  num pan;
  Position rightEye;
  Position rightEyebrowLeft;
  Position rightEyebrowRight;
  num roll;
  num tilt;
  Position upperLip;

  FaceTrackingData._internal(js.Proxy data) : super._internal() {
    if (data["hasFace"] != null) hasFace = data.hasFace;
    if (data["leftEye"] != null) leftEye = new Position._internalProxy(data["leftEye"]);
    // TODO: complete
    
    js.release(data);
  }
}

class Position {
  num x;
  num y;
  
  Position(this.x, this.y);
  
  Position._internalProxy(js.Proxy data) {
    if (data["x"] != null) x = data["x"];
    if (data["y"] != null) y = data["y"];
  }
}

/// Contains information about the success of a resource load.
class ResourceLoadResult extends HangoutEvent {
  /// True if the load successed, false otherwise.
  bool isLoaded;

  ResourceLoadResult._internal(js.Proxy data) : super._internal() {
    if (data["isLoaded"] != null) {
      isLoaded = data.isLoaded;
    } else {
      throw new HangoutAPIException("Invalid return value in onLoad callback");
    }
    js.release(data);
  }
}