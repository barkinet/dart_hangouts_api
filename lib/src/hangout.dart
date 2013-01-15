part of hangouts_api;

/**
 * Main Hangouts API class:
 * Provides basic information such as the list of participants,
 * the locale, and whether the app is initialized and visible.
 */
class Hangout {

  HangoutAv _av;
  HangoutAv get av => _av;
  HangoutData _data;
  HangoutData get data => _data;
  HangoutLayout _layout;
  HangoutLayout get layout => _layout;
  HangoutOnair _onair;
  HangoutOnair get onair => _onair;
  
  OnceEventHandler _onApiReady;
  OnceEventHandler get onApiReady => _onApiReady;
  ManyEventHandler _onAppVisible;
  ManyEventHandler get onAppVisible => _onAppVisible;
  ManyEventHandler _onEnabledParticipantsChanged;
  ManyEventHandler get onEnabledParticipantsChanged => _onEnabledParticipantsChanged;
  ManyEventHandler _onParticipantsAdded;
  ManyEventHandler get onParticipantsAdded => _onParticipantsAdded;
  ManyEventHandler _onParticipantsChanged;
  ManyEventHandler get onParticipantsChanged => _onParticipantsChanged;
  ManyEventHandler _onParticipantsDisabled;
  ManyEventHandler get onParticipantsDisabled => _onParticipantsDisabled;
  ManyEventHandler _onParticipantsEnabled;
  ManyEventHandler get onParticipantsEnabled => _onParticipantsEnabled;
  ManyEventHandler _onParticipantsRemoved;
  ManyEventHandler get onParticipantsRemoved => _onParticipantsRemoved;
  ManyEventHandler _onPreferredLocaleChanged;
  ManyEventHandler get onPreferredLocaleChanged => _onPreferredLocaleChanged;
  ManyEventHandler _onPublicChanged;
  ManyEventHandler get onPublicChanged => _onPublicChanged;
  ManyEventHandler _onTopicChanged;
  ManyEventHandler get onTopicChanged => _onTopicChanged;
  
  Hangout() {
    js.scoped(() {
      try {
        var c = js.context.gapi.hangout;
      } on NoSuchMethodError {
        throw new HangoutAPIException("Hangout API not available, please make sure that https://talkgadget.google.com/hangouts/_/api/hangout.js?v=1.3 is loaded.");
        return;
      }
    });
    
    _av = new HangoutAv._internal();
    _data = new HangoutData._internal();
    _layout = new HangoutLayout._internal();
    _onair = new HangoutOnair._internal();

    _onApiReady = new OnceEventHandler._internal(["onApiReady"], HangoutEvent.API_READY_EVENT);
    _onAppVisible = new ManyEventHandler._internal(["onAppVisible"], HangoutEvent.APP_VISIBLE_EVENT);
    _onEnabledParticipantsChanged = new ManyEventHandler._internal(["onEnabledParticipantsChanged"], HangoutEvent.ENABLED_PARTICIPANTS_CHANGED_EVENT);
    _onParticipantsAdded = new ManyEventHandler._internal(["onParticipantsAdded"], HangoutEvent.PARTICIPANTS_ADDED_EVENT);
    _onParticipantsChanged = new ManyEventHandler._internal(["onParticipantsChanged"], HangoutEvent.PARTICIPANTS_CHANGED_EVENT);
    _onParticipantsDisabled = new ManyEventHandler._internal(["onParticipantsDisabled"], HangoutEvent.PARTICIPANTS_DISABLED_EVENT);
    _onParticipantsEnabled = new ManyEventHandler._internal(["onParticipantsEnabled"], HangoutEvent.PARTICIPANTS_ENABLED_EVENT);
    _onParticipantsRemoved = new ManyEventHandler._internal(["onParticipantsRemoved"], HangoutEvent.PARTICIPANTS_REMOVED_EVENT);
    _onPreferredLocaleChanged = new ManyEventHandler._internal(["onPreferredLocaleChanged"], HangoutEvent.PREFERRED_LOCALE_CHANGED_EVENT);
    _onPublicChanged = new ManyEventHandler._internal(["onPublicChanged"], HangoutEvent.PUBLIC_CHANGED_EVENT);
    _onTopicChanged = new ManyEventHandler._internal(["onTopicChanged"], HangoutEvent.TOPIC_CHANGED_EVENT);
  }
  
  // TODO: Dummy needs to be filled
  List<Participant> getEnabledParticipants() => null;
  
  String getHangoutUrl() => simpleStringCall(["getHangoutUrl"]);
  
  String getHangoutId() => simpleStringCall(["getHangoutId"]);

  String getLocalParticipantLocale() => simpleStringCall(["getLocalParticipantLocale"]);
  
  String getPreferredLocale() => simpleStringCall(["getPreferredLocale"]);
  
  String getStartData() => simpleStringCall(["getStartData"]);
  
  // TODO: Dummy needs to be filled
  Participant getParticipantById(String participantId) => null;
  
  // TODO: Dummy needs to be filled
  Participant getLocalParticipant() => null;
  
  // TODO: Dummy needs to be filled
  List<Participant> getParticipants() => null;
  
  // TODO: Dummy needs to be filled
  String getTopic() => simpleStringCall(["getTopic"]);
  
  // TODO: Dummy needs to be filled
  void hideApp() => simpleVoidCall(["hideApp"]);
  
  // TODO: Dummy needs to be filled
  bool isApiReady() => simpleBoolCall(["isApiReady"]);
  
  // TODO: Dummy needs to be filled
  bool isAppVisible() => simpleBoolCall(["isAppVisible"]);
  
  // TODO: Dummy needs to be filled
  bool isPublic() => simpleBoolCall(["isPublic"]);
}

class Participant {
  String id;
  int displayIndex;
  bool hasMicrophone;
  bool hasCamera;
  bool hasAppEnabled;
  bool isBroadcaster;
  bool isInBroadcast;
  ParticipantPerson person;
  
  Participant._internal(js.Proxy data) {
    id = data["id"];
    hasMicrophone = data["hasMicrophone"];
    hasCamera = data["hasCamera"];
    hasAppEnabled  = data["hasAppEnabled"];
    isBroadcaster = data["isBroadcaster"];
    isInBroadcast = data["isInBroadcast"];
    if (data["person"] != null) person = new ParticipantPerson._internal(data["person"]);
  }
}

class ParticipantPerson {
  String id;
  String displayName;
  ParticipantPersonImage image;
  
  ParticipantPerson._internal(js.Proxy data) {
    id = data["id"];
    displayName = data["displayName"];
    if (data["image"] != null) image = new ParticipantPersonImage._internal(data["image"]);
  }
}

class ParticipantPersonImage {
  String url;
  
  ParticipantPersonImage._internal(js.Proxy data) {
    url = data["url"];
  }
}

// Events ---------------------

class ApiReadyEvent extends HangoutEvent {
  bool isApiReady;
  ApiReadyEvent._internal(js.Proxy data) : super._internal() {
    if (data["isApiReady"] != null) {
      isApiReady = data.isApiReady;
    } else {
      throw new HangoutAPIException("Invalid return value in onApiReady callback");
    }
    js.release(data);
  }
}

class AppVisibleEvent extends HangoutEvent {
  bool isAppVisible;
  AppVisibleEvent._internal(js.Proxy data) : super._internal() {
    if (data["isAppVisible"] != null) {
      isAppVisible = data.isAppVisible;
    } else {
      throw new HangoutAPIException("Invalid return value in onAppVisible callback");
    }
    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class EnabledParticipantsChangedEvent extends HangoutEvent {
  
  
  EnabledParticipantsChangedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class ParticipantsAddedEvent extends HangoutEvent {

  ParticipantsAddedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class ParticipantsChangedEvent extends HangoutEvent {

  ParticipantsChangedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class ParticipantsDisabledEvent extends HangoutEvent {

  ParticipantsDisabledEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class ParticipantsEnabledEvent extends HangoutEvent {

  ParticipantsEnabledEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class ParticipantsRemovedEvent extends HangoutEvent {

  ParticipantsRemovedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class PreferredLocaleChangedEvent extends HangoutEvent {

  PreferredLocaleChangedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class PublicChangedEvent extends HangoutEvent {

  PublicChangedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}

// TODO: Dummy needs to be filled
class TopicChangedEvent extends HangoutEvent {

  TopicChangedEvent._internal(js.Proxy data) : super._internal() {

    js.release(data);
  }
}
