part of hangouts_api;

/// Provides ability to add sound effects and attach image overlays to faces.
class HangoutAvEffects {
  
  ManyEventHandler _onFaceTrackingDataChanged;

  FaceTrackingFeatureEnum _faceTrackingFeature;
  
  /**
   * Identifiers for the features that can be tracked by a [FaceTrackingOverlay].
   * "Left" and "right" are from how others view the face.
   */
  FaceTrackingFeatureEnum get FaceTrackingFeature => _faceTrackingFeature;
  
  ResourceStateEnum _resourceState;
  
  /// Possible states of a resource.
  ResourceStateEnum get ResourceState => _resourceState;
  
  ScaleReferenceEnum _scaleReference;
  
  /// Possible values for the aspect of the video feed that an [Overlay] is scaled relative to.
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
  
  /**
   * Creates a new [AudioResource].
   * Warning: Creating an audio resource allocates memory in the plugin.
   * Allocating too many resources without disposing them can cause the hangout to run out of memory and halt.
   * Dispose of audio resources by using the dispose method. 
   */
  AudioResource createAudioResource(String url) {
    var data = _makeProxyCall(["av", "effects", "createAudioResource"], [url]);
    return new AudioResource._internal(data);
  }
  
  /**
   * Creates a new [ImageResource].
   * Warning: Creating an image resource allocates memory in the plugin.
   * Allocating too many resources without disposing them can cause the hangout to run out of memory and halt.
   * Dispose of image resources by using the dispose method.
   */ 
  ImageResource createImageResource(String url) {
    var data = _makeProxyCall(["av", "effects", "createImageResource"], [url]);
    return new ImageResource._internal(data);
  }
}

/**
 *  Object used to load an audio file which can be used to play sounds.
 *  Create an AudioResource with createAudioResource.
 */
class AudioResource extends ProxyObject {
  
  OnceEventHandler _onLoad;
  
  /// Handles callback to be called when resource loads.
  OnceEventHandler get onLoad => _onLoad;
  
  AudioResource._internal(js.Proxy proxy) : super._internal(proxy) {
    _onLoad = new OnceEventHandler._internalProxy(_proxy, HangoutEvent.RESOURCE_LOAD_RESULT);
  }
  
  /**
   *  Creates a new instance of a sound.
   *  
   *  opt_params : {localOnly: boolean, loop: boolean, volume: number}
   *  The options for the newly created sound.
   *  If the localOnly parameter is true, the sound plays only to the local participant;
   *  if false, the sound plays to all participants and, if in a Hangout On Air, to broadcast viewers.
   */
  Sound createSound([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("createSound", [optParams]);
    else
      data = this._makeProxyCall("createSound");
    return new Sound._internal(this, data); 
  }
  
  /// Disposes the resource and all sounds created from the resource.
  void dispose() => this._makeVoidCall("dispose");
  
  /// Returns the state of the resource.
  String getState() => this._makeStringCall("getState");
  
  /// Returns the URL of the audio file for the resource.
  String getUrl() => this._makeStringCall("getUrl");
  
  /// Returns true if the resource has been disposed.
  bool isDisposed() => this._makeBoolCall("isDisposed");
  
  /// Returns true if the resource has successfully loaded.
  bool isLoaded() => this._makeBoolCall("isLoaded");
  
  /**
   *  Creates a new instance of a sound and starts it playing. 
   *  
   *  opt_params : {localOnly: boolean, loop: boolean, volume: number}
   *  The options for the newly created sound.
   *  If the localOnly parameter is true, the sound plays only to the local participant;
   *  if false, the sound plays to all participants and, if in a Hangout On Air, to broadcast viewers.
   */
  Sound play([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("play", [optParams]);
    else
      data = this._makeProxyCall("play");
    return new Sound._internal(this, data);
  }
  
}

/**
 * Object used to control one instance of an image that tracks a face and is laid over the video feed of the local participant.
 * The image is visible to all participants.
 * Create a FaceTrackingOverlay using createFaceTrackingOverlay or showFaceTrackingOverlay.
 */
class FaceTrackingOverlay extends ProxyObject {
  
  ImageResource _imageResource;
  
  FaceTrackingOverlay._internal(ImageResource this._imageResource, js.Proxy proxy) : super._internal(proxy);
  
  /// Disposes the overlay.
  void dispose() => this._makeVoidCall("dispose");
  
  /// Returns the [ImageResource] used to create this object.
  ImageResource getImageResource() => _imageResource;
  
  /// Returns the offset of the image overlay from the [FaceTrackingFeatureEnum].
  Position getOffset() {
    var data = this._makeProxyCall("getOffset");
    var pos;
    js.scoped(() {
      if (data != null) {
        pos = new Position._internalProxy(data);
      }
      js.release(data);
    });
    return pos;
  }
  
  /// Returns true if the image will rotate as the face rotates, false otherwise.
  bool getRotateWithFace() => this._makeBoolCall("getRotateWithFace");
  
  /**
   * Returns the base rotation of an image in radians.
   * This does not include any rotation occurring because of the getRotateWithFace flag.
   */
  num getRotation() => this._makeNumCall("getRotation");

  /**
   * Returns the scale in relation to the natural image size of the overlay.
   * This does not include any scaling occurring because of the getScaleWithFace flag.
   * Example: a scale of 2 would cause the image to be twice its natural size.
   */
  num getScale() => this._makeNumCall("getScale");
  
  /// Returns true if the size of the image will scale with the size of the face that is being tracked, false otherwise.
  bool getScaleWithFace() => this._makeBoolCall("getScaleWithFace");
  
  /// Returns the feature of the face that the image overlay is attached to.
  String getTrackingFeature() => this._makeStringCall("getTrackingFeature");
  
  /// Returns true if the overlay has been disposed.
  bool isDisposed() => this._makeBoolCall("isDisposed");
  
  /// Returns true if the image overlay is currently visible in the local participant's video feed, false otherwise.
  bool isVisible() => this._makeBoolCall("isVisible");
  
  /**
   * Sets the offset of the image overlay from the feature of the face being tracked.
   * With an offset of (0,0), the overlay is centered on the feature.
   * 
   * The x offset ranges from -1 to 1, where 1 is the width of the video feed, and positive values move the overlay toward the right.
   * The y offset also ranges from -1 to 1, where 1 is the height of the video feed, and postive values move the overlay toward the bottom.
   * 
   * value : number|{x: number, y: number}
   * Either a single number representing the x offset, or a Map with the x, y offset.
   * 
   * opt_y : number
   * The y offset (this parameter is ignored if value is an object.)
   */
  void setOffset(value, [num opt_y]) {
    if (value is! num && value is! Map<String, num>) {
      throw(new ArgumentError("value has be be num or Map<String, num>"));
      return;
    }
    if (value is num) {
      if(?opt_y && opt_y != null) {
        this._makeVoidCall("setOffset", [value, opt_y]);
      } else {
        throw(new ArgumentError("If value is num, opt_y has to be set as well"));
      }
    } else {
      this._makeVoidCall("setOffset", [value]);
    }
  }

  /// Sets whether the image should rotate as the face rotates.
  void setRotateWithFace(bool shouldRotate) => this._makeVoidCall("setRotateWithFace", [shouldRotate]);
  
  /// Sets the rotation for an image in radians. This will be in addition to any rotation caused by setRotateWithFace.
  void setRotation(num rotation) => this._makeVoidCall("setRotation", [rotation]);
  
  /// Sets the amount an image should be scaled.
  void setScale(num rotation) => this._makeVoidCall("setScale", [rotation]);
  
  /// Sets whether an image should scale as the face being tracked gets larger or smaller.
  void setScaleWithFace(bool shouldScale) => this._makeVoidCall("setScaleWithFace", [shouldScale]);
  
  /// Sets the face feature that the image overlay is attached to.
  void setTrackingFeature(String feature) => this._makeVoidCall("setTrackingFeature", [feature]);
  
  /// Sets the image overlay to be visible or not.
  void setVisible(bool visible) => this._makeVoidCall("setVisible", [visible]);
}

/**
 * Object used to load an image file which can be overlaid on the video feed.
 * Create an ImageResource with createImageResource.
 */
class ImageResource extends ProxyObject {
  OnceEventHandler _onLoad;

  /// Handles callback to be called when resource loads.
  OnceEventHandler get onLoad => _onLoad;
  
  ImageResource._internal(js.Proxy proxy) : super._internal(proxy) {
    _onLoad = new OnceEventHandler._internalProxy(_proxy, HangoutEvent.RESOURCE_LOAD_RESULT);
  }
  
  /**
   * Creates a new instance of a face tracking overlay with this image.
   * 
   * opt_params :
   * {trackingFeature: gapi.hangout.av.effects.FaceTrackingFeature,
   *  offset: {x: number, y: number},
   *  rotateWithFace: boolean, rotation: number, scale: number, scaleWithFace: boolean}
   */
  FaceTrackingOverlay createFaceTrackingOverlay([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("createFaceTrackingOverlay", [optParams]);
    else
      data = this._makeProxyCall("createFaceTrackingOverlay");
    return new FaceTrackingOverlay._internal(this, data); 
  }
  
  /**
   * Creates a new instance of an overlay with this image.
   * 
   * opt_params :
   * {position: {x: number, y: number}, rotation: number,
   * scale: {magnitude: number, reference: gapi.hangout.av.effects.ScaleReference}}
   */
  Overlay createOverlay([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("createOverlay", [optParams]);
    else
      data = this._makeProxyCall("createOverlay");
    return new Overlay._internal(this, data); 
  }
  
  /// Disposes the overlay.
  void dispose() => this._makeVoidCall("dispose");
  
  /// Returns the state of the resource.
  String getState() => this._makeStringCall("getState");
  
  /// The URL of the image file for the resource.
  String getUrl() => this._makeStringCall("getUrl");
  
  /// Returns true if the resource has been disposed.
  bool isDisposed() => this._makeBoolCall("isDisposed");
  
  /// Returns true if the resource has successfully loaded.
  bool isLoaded() => this._makeBoolCall("isLoaded");
  
  /**
   * Creates a new instance of a face tracking overlay with this image and displays it.
   * 
   * opt_params :
   * {trackingFeature: gapi.hangout.av.effects.FaceTrackingFeature,
   *  offset: {x: number, y: number},
   *  rotateWithFace: boolean, rotation: number, scale: number, scaleWithFace: boolean}
   */
  FaceTrackingOverlay showFaceTrackingOverlay([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("showFaceTrackingOverlay", [optParams]);
    else
      data = this._makeProxyCall("showFaceTrackingOverlay");
    return new FaceTrackingOverlay._internal(this, data); 
  }

  /**
   * Creates a new instance of an overlay with this image and displays it.
   * 
   * opt_params :
   * {position: {x: number, y: number}, rotation: number,
   * scale: {magnitude: number, reference: gapi.hangout.av.effects.ScaleReference}}
   */
  Overlay showOverlay([Map optParams]) {
    var data;
    if (?optParams && optParams != null)
      data = this._makeProxyCall("showOverlay", [optParams]);
    else
      data = this._makeProxyCall("showOverlay");
    return new Overlay._internal(this, data); 
  }
}

/**
 * Object used to control one instance of an image laid over the video feed of the local participant
 * and is positioned relative to the center of the video feed.
 * The image is visible to all participants.
 * Useful for decorations such as captions, borders, or animations that don't require face tracking.
 * Create an Overlay using createOverlay or showOverlay.
 */
class Overlay extends ProxyObject {
  
  ImageResource _imageResource;
  
  Overlay._internal(ImageResource this._imageResource, js.Proxy proxy) : super._internal(proxy);
  
  /// Disposes the overlay.
  void dispose() => this._makeVoidCall("dispose");
  
  /// Returns the [ImageResource] used to create this object.
  ImageResource getImageResource() => _imageResource;
  
  /// Returns the position of the image overlay
  Position getPosition() {
    var data = this._makeProxyCall("getPosition");
    var pos;
    js.scoped(() {
      if (data != null) {
        pos = new Position._internalProxy(data);
      }
      js.release(data);
    });
    return pos;
  }
  
  /// Returns the rotation of an image in radians.
  num getRotation() => this._makeNumCall("getRotation");
  
  /**
   * Returns the scale of the overlay.
   * 
   * Example: a scale of {magnitude: 1, reference: gapi.hangout.av.effects.ScaleReference.WIDTH}
   * would indicate that the image will be scaled so its width is the same as the video feed.
   */
  Map getScale() {
    var data = this._makeProxyCall("getScale");
    var scale;
    js.scoped(() {
      if (data != null) {
        scale = JSON.parse(js.context.JSON.stringify(data));
      }
      js.release(data);
    });
    return scale;
  }
  
  /// Returns true if the overlay has been disposed.
  bool isDisposed() => this._makeBoolCall("isDisposed");
  
  /// Returns true if the image overlay is currently visible in the local participant's video feed, false otherwise.
  bool isVisible() => this._makeBoolCall("isVisible");
  
  /**
   * Sets the position of the image overlay. With an offset of (0,0), the overlay is centered on the video feed.
   * 
   * Positive x values move the overlay toward the right and a value of 1 is equal to the width of the video feed.
   * Positive y values move the overlay toward the bottom and a value of 1 is equal to the height of the video feed.
   * 
   * Example: an x of -0.5 and a y of 0.5 would position the overlay in the bottom left corner of the video feed.
   * 
   * value : number|{x: number, y: number}
   * Either a single number representing the x position, or an object with the x, y position.
   * 
   * opt_y : number
   * The y position (this parameter is ignored if value is an object.)
   */
  void setPosition(value, [num opt_y]) {
    if (value is! num && value is! Map<String, num>) {
      throw(new ArgumentError("value has be be num or Map<String, num>"));
      return;
    }
    if (value is num) {
      if(?opt_y && opt_y != null) {
        this._makeVoidCall("setPosition", [value, opt_y]);
      } else {
        throw(new ArgumentError("If value is num, opt_y has to be set as well"));
      }
    } else {
      this._makeVoidCall("setPosition", [value]);
    }
  }
  
  /// Sets the rotation for an image in radians.
  void setRotation(num rotation) => this._makeVoidCall("setRotation", [rotation]);
  
  /**
   * Sets the amount an image should be scaled.
   * 
   * value : number|{magnitude: number, reference: [ScaleReference]}
   * Either a single number representing amount the image should be scaled, or an object with the magnitude and reference.
   * 
   * opt_reference : [ScaleReference]
   * The aspect of the video feed which the image is scaled relative to.
   */
  void setScale(value, [String opt_reference]) {
    if (value is! num && value is! Map) {
      throw(new ArgumentError("value has be be num or Map"));
      return;
    }
    if (value is num) {
      if(?opt_reference && opt_reference != null) {
        this._makeVoidCall("setScale", [value, opt_reference]);
      } else {
        throw(new ArgumentError("If value is num, opt_reference has to be set as well"));
      }
    } else {
      this._makeVoidCall("setScale", [value]);
    }
  }
  
  /// Sets the image overlay to be visible or not.
  void setVisible(bool visible) => this._makeVoidCall("setVisible", [visible]);
}

/**
 * Object used to control one instance of a sound.
 * Sounds played through this API will automatically be echo-cancelled.
 * Create a Sound using createSound.
 */
class Sound extends ProxyObject {
  
  AudioResource _audioResource;
  
  Sound._internal(AudioResource this._audioResource, js.Proxy proxy) : super._internal(proxy);
  
  /// Disposes the sound.
  void dispose() => this._makeVoidCall("dispose");
  
  /// The [AudioResource] used to create this Sound.
  AudioResource getAudioResource() => _audioResource;
  
  /// The volume, in the range 0-1, of the sound.
  num getVolume() => this._makeNumCall("getVolume");
  
  /// Returns true if the sound has been disposed.
  bool isDisposed() => this._makeBoolCall("isDisposed");
  
  /**
   * Returns true if the sound plays only to the local participant.
   * Returns false if the sound plays to all participants and, if in a Hangout On Air, to broadcast viewers.
   */
  bool isLocalOnly() => this._makeBoolCall("isLocalOnly");
  
  /// Returns true if the sound will repeat, false otherwise.
  bool isLooped() => this._makeBoolCall("isLooped");
  
  /// Starts playing the sound.
  void play() => this._makeVoidCall("play");
  
  /// Sets whether the sound will repeat or not, false otherwise.
  void setLoop(bool loop) => this._makeVoidCall("setLoop", [loop]);
  
  /// Sets the volume of the sound, in the range 0-1.
  void setVolume(num volume) => this._makeVoidCall("setVolume", [volume]);
  
  /// Stops the sound if it is currently playing.
  void stop() => this._makeVoidCall("stop");
}

/**
 * The positions of points on the face detected in a video feed.
 * The x-y origin is the center of the frame.
 * "Left" and "right" (such as leftEye) are with respect to how others view the face.
 * Likewise, positive x is to the right as others view the face.
 * The width and height of the feed are each equal to 1.0 unit.
 * Pan, roll, and tilt are specified in radians, where 0 radians is center and positive is to the right from the viewer's perspective.
 */
class FaceTrackingData extends HangoutEvent {
  
  /// Indicates whether there is a face in the video feed.
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


/**
 * Identifiers for the features that can be tracked by a [FaceTrackingOverlay].
 * "Left" and "right" are from how others view the face.
 */
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

/// Possible states of a resource.
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

/**
 * Possible values for the aspect of the video feed that an [Overlay] is scaled relative to.
 */
class ScaleReferenceEnum {
  
  final String HEIGHT;
  final String WIDTH;
  
  ScaleReferenceEnum._internal(js.Proxy data) :
    HEIGHT = data["HEIGHT"],
    WIDTH = data["WIDTH"];
  
}