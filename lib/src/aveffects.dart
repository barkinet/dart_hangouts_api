part of hangouts_api;

/// Provides ability to add sound effects and attach image overlays to faces.
class HangoutAvEffects {
  
  ManyEventHandler _onFaceTrackingDataChanged;

  FaceTrackingFeatureEnum _faceTrackingFeature;
  FaceTrackingFeatureEnum get FaceTrackingFeature => _faceTrackingFeature;
  
  ResourceStateEnum _resourceState;
  ResourceStateEnum get ResourceState => _resourceState;
  
  ScaleReferenceEnum _scaleReference;
  ScaleReferenceEnum get ScaleReference => _scaleReference;
  
  /// Handles callbacks to be called when the local participant starts or stops sending video.
  ManyEventHandler get onFaceTrackingDataChanged => _onFaceTrackingDataChanged;
  
  
  HangoutAvEffects._internal() {
    _onFaceTrackingDataChanged = new ManyEventHandler._internal(["av", "effects", "onFaceTrackingDataChanged"], HangoutEvent.FACE_TRACKING_DATA);
    
    js.scoped(() {
      var data = js.context.gapi.hangout.av.effects.FaceTrackingFeature;
      _faceTrackingFeature = new FaceTrackingFeatureEnum._internal(data);
      
      data = js.context.gapi.hangout.av.effects.ResourceState;
      _resourceState = new ResourceStateEnum._internal(data);
      
      data = js.context.gapi.hangout.av.effects.ScaleReference;
      _scaleReference = new ScaleReferenceEnum._internal(data);
    });
  }
}

class AudioResource extends ProxyObject {
  OnceEventHandler _onLoad;
  
  OnceEventHandler get onLoad => _onLoad;
  
  AudioResource._internal(js.Proxy proxy) : super._internal(proxy) {
    _onLoad = new OnceEventHandler._internalProxy(_proxy, HangoutEvent.RESOURCE_LOAD_RESULT);
  }
}

class FaceTrackingOverlay extends ProxyObject {
  
  FaceTrackingOverlay._internal(js.Proxy proxy) : super._internal(proxy) {
    
  }
}

class ImageResource extends ProxyObject {
  OnceEventHandler _onLoad;
  
  OnceEventHandler get onLoad => _onLoad;
  
  ImageResource._internal(js.Proxy proxy) : super._internal(proxy) {
    _onLoad = new OnceEventHandler._internalProxy(_proxy, HangoutEvent.RESOURCE_LOAD_RESULT);
  }
}

class Overlay extends ProxyObject {
  
  Overlay._internal(js.Proxy proxy) : super._internal(proxy) {
    
  }
}

class Sound extends ProxyObject {
  
  Sound._internal(js.Proxy proxy) : super._internal(proxy) {
    
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
    if (data["leftEyebrowLeft"] != null) leftEyebrowLeft = new Position._internalProxy(data["leftEyebrowLeft"]);
    if (data["leftEyebrowRight"] != null) leftEyebrowRight = new Position._internalProxy(data["leftEyebrowRight"]);
    if (data["lowerLip"] != null) lowerLip = new Position._internalProxy(data["lowerLip"]);
    if (data["mouthCenter"] != null) mouthCenter = new Position._internalProxy(data["mouthCenter"]);
    if (data["mouthLeft"] != null) mouthLeft = new Position._internalProxy(data["mouthLeft"]);
    if (data["mouthRight"] != null) mouthRight = new Position._internalProxy(data["mouthRight"]);
    if (data["noseRoot"] != null) noseRoot = new Position._internalProxy(data["noseRoot"]);
    if (data["noseTip"] != null) noseTip = new Position._internalProxy(data["noseTip"]);
    if (data["pan"] != null) pan = data.pan;
    if (data["rightEye"] != null) rightEye = new Position._internalProxy(data["rightEye"]);
    if (data["rightEyebrowLeft"] != null) rightEyebrowLeft = new Position._internalProxy(data["rightEyebrowLeft"]);
    if (data["rightEyebrowRight"] != null) rightEyebrowRight = new Position._internalProxy(data["rightEyebrowRight"]);
    if (data["roll"] != null) roll = data.roll;
    if (data["tilt"] != null) tilt = data.tilt;
    if (data["upperLip"] != null) upperLip = new Position._internalProxy(data["upperLip"]);
    
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



class FaceTrackingFeatureEnum {
  
  final String LEFT_EYE;
  final String LEFT_EYEBROW_LEFT;
  final String LEFT_EYEBROW_RIGHT;
  final String LOWER_LIP;
  final String MOUTH_CENTER;
  final String MOUTH_LEFT;
  final String MOUTH_RIGHT;
  final String NOSE_ROOT;
  final String NOSE_TIP;
  final String RIGHT_EYE;
  final String RIGHT_EYEBROW_LEFT;
  final String RIGHT_EYEBROW_RIGHT;
  final String UPPER_LIP; 
  
  FaceTrackingFeatureEnum._internal(js.Proxy data) :
    LEFT_EYE = data["LEFT_EYE"],
    LEFT_EYEBROW_LEFT = data["LEFT_EYEBROW_LEFT"],
    LEFT_EYEBROW_RIGHT = data["LEFT_EYEBROW_RIGHT"],
    LOWER_LIP = data["LOWER_LIP"],
    MOUTH_CENTER = data["MOUTH_CENTER"],
    MOUTH_LEFT = data["MOUTH_LEFT"],
    MOUTH_RIGHT = data["MOUTH_RIGHT"],
    NOSE_ROOT = data["NOSE_ROOT"],
    NOSE_TIP = data["NOSE_TIP"],
    RIGHT_EYE = data["RIGHT_EYE"],
    RIGHT_EYEBROW_LEFT = data["RIGHT_EYEBROW_LEFT"],
    RIGHT_EYEBROW_RIGHT = data["RIGHT_EYEBROW_RIGHT"],
    UPPER_LIP = data["UPPER_LIP"];
}


class ResourceStateEnum {
  
  final String DISPOSED;
  final String ERROR;
  final String LOADING;
  final String LOADED;
  
  ResourceStateEnum._internal(js.Proxy data) :
    DISPOSED = data["DISPOSED"],
    ERROR = data["ERROR"],
    LOADING = data["LOADING"],
    LOADED = data["LOADED"];
  
}

class ScaleReferenceEnum {
  
  final String HEIGHT;
  final String WIDTH;
  
  ScaleReferenceEnum._internal(js.Proxy data) :
    HEIGHT = data["HEIGHT"],
    WIDTH = data["WIDTH"];
  
}