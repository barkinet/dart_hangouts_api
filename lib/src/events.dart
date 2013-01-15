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
  
  HangoutEvent._internal();
  
  factory HangoutEvent(type, js.Proxy data) {
    // gapi.hangout events
    if (type == API_READY_EVENT) return new ApiReadyEvent._internal(data);
    if (type == APP_VISIBLE_EVENT) return new AppVisibleEvent._internal(data);
    if (type == ENABLED_PARTICIPANTS_CHANGED_EVENT) return new EnabledParticipantsChangedEvent._internal(data);
    if (type == PARTICIPANTS_ADDED_EVENT) return new ParticipantsAddedEvent._internal(data);
    if (type == PARTICIPANTS_CHANGED_EVENT) return new ParticipantsChangedEvent._internal(data);
    if (type == PARTICIPANTS_DISABLED_EVENT) return new ParticipantsDisabledEvent._internal(data);
    if (type == PARTICIPANTS_ENABLED_EVENT) return new ParticipantsEnabledEvent._internal(data);
    if (type == PARTICIPANTS_REMOVED_EVENT) return new ParticipantsRemovedEvent._internal(data);
    if (type == PREFERRED_LOCALE_CHANGED_EVENT) return new PreferredLocaleChangedEvent._internal(data);
    if (type == PUBLIC_CHANGED_EVENT) return new PublicChangedEvent._internal(data);
    if (type == TOPIC_CHANGED_EVENT) return new TopicChangedEvent._internal(data);
    
    // gapi.hangout.av events
    if (type == CAMERA_MUTE_EVENT) return new CameraMuteEvent._internal(data);
  }
}

class OnceEventHandler {
  
  List _callbacks;
  bool _registered;
  List<String> _event;
  int _eventType;
  
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
        var c = js.context.gapi.hangout;
        _event.forEach((s) {
          c = c[s];
        });
        c.add(new js.Callback.once(_callback));
      });
    }
  }
  
  void remove(Function f) {
    if (_callbacks.indexOf(f) >= 0) {
      _callbacks.removeAt(_callbacks.indexOf(f));
    }
  }
  
  OnceEventHandler._internal(List<String> this._event, int this._eventType) {
    _callbacks = new List();
    _registered = false;
  }
}

class ManyEventHandler {
  List _callbacks;
  bool _registered;
  List<String> _event;
  int _eventType;
  
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
        var c = js.context.gapi.hangout;
        _event.forEach((s) {
          c = c[s];
        });
        c.add(new js.Callback.many(_callback));
      });
    }
  }
  
  void remove(Function f) {
    if (_callbacks.indexOf(f) >= 0) {
      _callbacks.removeAt(_callbacks.indexOf(f));
    }
  }
  
  ManyEventHandler._internal(List<String> this._event, int this._eventType) {
    _callbacks = new List();
    _registered = false;
  }
}