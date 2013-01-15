part of hangouts_api;

abstract class HangoutEvent {
  
  // gapi.hangout events
  static const int API_READY_EVENT = 1;
  static const int APP_VISIBLE_EVENT = 2;
  static const int ENABLED_PARTICIPANTS_CHANGED_EVENT = 3;
  static const int PARTICIPANTS_ADDED_EVENT = 4;
  static const int PARTICIPANTS_CHANGED_EVENT = 5;
  static const int PARTICIPANTS_DISABLED_EVENT = 6;
  static const int PARTICIPANTS_ENABLED_EVENT = 7;
  static const int PARTICIPANTS_REMOVED_EVENT = 8;
  static const int PREFERRED_LOCALE_CHANGED_EVENT = 9;
  static const int PUBLIC_CHANGED_EVENT = 10;
  static const int TOPIC_CHANGED_EVENT = 11;
  
  // gapi.hangout.av events
  static const int CAMERA_MUTE_EVENT = 20;
  static const int HAS_CAMERA_EVENT = 21;
  static const int HAS_MICROPHONE_EVENT = 22;
  static const int HAS_SPEAKERS_EVENT = 23;
  static const int LOCAL_PARTICIPANT_VIDEO_MIRRORED_CHANGED_EVENT = 24;
  static const int MICROPHONE_MUTE_EVENT = 25;
  static const int VOLUMES_CHANGED_EVENT = 26;
  
  // gapi.hangout.av.effects events
  static const int FACE_TRACKING_DATA = 30;
  static const int RESOURCE_LOAD_RESULT = 31;
  
  // gapi.hangout.data events
  static const int MESSAGE_RECEIVED_EVENT = 32;
  static const int STATE_CHANGED_EVENT = 33;
  
  HangoutEvent._internal();
  
  factory HangoutEvent(type, js.Proxy data) {
    switch (type) {
    // gapi.hangout events
      case API_READY_EVENT:return new ApiReadyEvent._internal(data);
      case APP_VISIBLE_EVENT: return new AppVisibleEvent._internal(data);
      case ENABLED_PARTICIPANTS_CHANGED_EVENT: return new EnabledParticipantsChangedEvent._internal(data);
      case PARTICIPANTS_ADDED_EVENT: return new ParticipantsAddedEvent._internal(data);
      case PARTICIPANTS_CHANGED_EVENT: return new ParticipantsChangedEvent._internal(data);
      case PARTICIPANTS_DISABLED_EVENT: return new ParticipantsDisabledEvent._internal(data);
      case PARTICIPANTS_ENABLED_EVENT: return new ParticipantsEnabledEvent._internal(data);
      case PARTICIPANTS_REMOVED_EVENT: return new ParticipantsRemovedEvent._internal(data);
      case PREFERRED_LOCALE_CHANGED_EVENT: return new PreferredLocaleChangedEvent._internal(data);
      case PUBLIC_CHANGED_EVENT: return new PublicChangedEvent._internal(data);
      case TOPIC_CHANGED_EVENT: return new TopicChangedEvent._internal(data);
      
      // gapi.hangout.av events
      case CAMERA_MUTE_EVENT: return new CameraMuteEvent._internal(data);
      case HAS_CAMERA_EVENT: return new HasCameraEvent._internal(data);
      case HAS_MICROPHONE_EVENT: return new HasMicrophoneEvent._internal(data);
      case HAS_SPEAKERS_EVENT: return new HasSpeakersEvent._internal(data);
      case LOCAL_PARTICIPANT_VIDEO_MIRRORED_CHANGED_EVENT: return new LocalParticipantVideoMirroredChangedEvent._internal(data);
      case MICROPHONE_MUTE_EVENT: return new MicrophoneMuteEvent._internal(data);
      case VOLUMES_CHANGED_EVENT: return new VolumesChangedEvent._internal(data);
      
      // gapi.hangout.av.effects events
      case FACE_TRACKING_DATA: return new FaceTrackingData._internal(data);
      case RESOURCE_LOAD_RESULT: return new ResourceLoadResult._internal(data);
      
      // gapi.hangout.data events
      case MESSAGE_RECEIVED_EVENT: return new MessageReceivedEvent._internal(data);
      case STATE_CHANGED_EVENT: return new StateChangedEvent._internal(data);      
      
      default: throw(new HangoutAPIException("Unknown Event Type"));
    }
  }
}

abstract class EventHandler {

  List _callbacks;
  bool _registered;
  List<String> _event;
  js.Proxy _proxy;
  int _eventType;
  
  EventHandler._internal(List<String> this._event, int this._eventType) {
    _callbacks = new List();
    _registered = false;
  }
  
  EventHandler._internalProxy(js.Proxy this._proxy, int this._eventType) {
    _callbacks = new List();
    _registered = false;
  }
  
  void _callback(js.Proxy eventData);
  void add(Function f);

  void remove(Function f) {
    if (_callbacks.indexOf(f) >= 0) {
      _callbacks.removeAt(_callbacks.indexOf(f));
    }
  }
  
}

class OnceEventHandler extends EventHandler {
  
  OnceEventHandler._internal(List<String> event, int eventType) : super._internal(event, eventType);
  OnceEventHandler._internalProxy(js.Proxy proxy, int eventType) : super._internalProxy(proxy, eventType);
  
  void _callback(js.Proxy eventData) {
    var eventObj = new HangoutEvent(_eventType, eventData);
    _callbacks.forEach((f) {
      f(eventObj);
    });
    _callbacks.clear();
    _registered = false;
  }
  
  void add(Function f) {
    if (_callbacks.contains(f)) return;
    _callbacks.add(f);
    if (!_registered) {
      _registered = true;
      js.scoped(() {
        var call;
        if (_proxy != null) {
          call = _proxy;
        } else {
          call = js.context.gapi.hangout;
          _event.forEach((s) {
            call = call[s];
          });
        }
        call.add(new js.Callback.once(_callback));
      });
    }
  }  
}

class ManyEventHandler extends EventHandler{
  
  ManyEventHandler._internal(List<String> event, int eventType) : super._internal(event, eventType);
  ManyEventHandler._internalProxy(js.Proxy proxy, int eventType) : super._internalProxy(proxy, eventType);
  
  void _callback(js.Proxy eventData) {
    var eventObj = new HangoutEvent(_eventType, eventData);
    _callbacks.forEach((f) {
      f(eventObj);
    });
  }
  
  void add(Function f) {
    if (_callbacks.contains(f)) return;
    _callbacks.add(f);
    if (!_registered) {
      _registered = true;
      js.scoped(() {
        var call;
        if (_proxy != null) {
          call = _proxy;
        } else {
          call = js.context.gapi.hangout;
          _event.forEach((s) {
            call = call[s];
          });
        }
        call.add(new js.Callback.many(_callback));
      });
    }
  }
}