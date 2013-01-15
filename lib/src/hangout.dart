part of hangouts_api;

/**
 * Main Hangouts API class:
 * Provides basic information such as the list of participants,
 * the locale, and whether the app is initialized and visible.
 */
class Hangout {

  HangoutAv _av;
  HangoutData _data;
  HangoutLayout _layout;
  HangoutOnair _onair;
  
  /// Provides ability to control hangout microphones, cameras, speakers and volume levels, as well as effects
  HangoutAv get av => _av;
  
  /// Provides functions for sharing data (getting and setting state) between participants in a hangout.
  HangoutData get data => _data;
  
  /// Provides ability to set UI layout elements such as the video feed, chat pane, and notices.
  HangoutLayout get layout => _layout;
  
  /// Provides ability for interacting with Hangouts On Air
  HangoutOnair get onair => _onair;
  
  OnceEventHandler _onApiReady;
  ManyEventHandler _onAppVisible;
  ManyEventHandler _onEnabledParticipantsChanged;
  ManyEventHandler _onParticipantsAdded;
  ManyEventHandler _onParticipantsChanged;
  ManyEventHandler _onParticipantsDisabled;
  ManyEventHandler _onParticipantsEnabled;
  ManyEventHandler _onParticipantsRemoved;
  ManyEventHandler _onPreferredLocaleChanged;
  ManyEventHandler _onPublicChanged;
  ManyEventHandler _onTopicChanged;
  
  /**
   * Handles callbacks to be called when the gapi.hangout API becomes ready to use.
   * If the API is already initialized, the callback will be called at the next event dispatch.
   */
  OnceEventHandler get onApiReady => _onApiReady;
  
  /// Handles callbacks to be called  when the app is shown or hidden.
  ManyEventHandler get onAppVisible => _onAppVisible;
  
  /**
   * Handles callbacks to be called whenever the set of participants who are running this app changes.
   * The argument to the callback is an [EnabledParticipantsChangedEvent] that holds all participants who have enabled the app since the last time the event fired.
   */
  ManyEventHandler get onEnabledParticipantsChanged => _onEnabledParticipantsChanged;

  /**
   * Handles callbacks to be called whenever participants join the hangout.
   * The argument to the callback is an [ParticipantsAddedEvent] that holds the particpants who have joined since the last time the event fired.
   */
  ManyEventHandler get onParticipantsAdded => _onParticipantsAdded;
  
  /**
   * Handles callbacks to be called whenever there is any change in the participants in the hangout.
   * The argument to the callback is an [ParticipantsChangedEvent] that holds holds the participants currently in the hangout.
   */
  ManyEventHandler get onParticipantsChanged => _onParticipantsChanged;
  
  /**
   * Handles callbacks to be called whenever a participant stops running this app.
   * The argument to the callback is an [ParticipantsDisabledEvent] that holds the participants who have stopped running this app since the last time the event fired.
   */
  ManyEventHandler get onParticipantsDisabled => _onParticipantsDisabled;
  
  /**
   * Handles callbacks to be called whenever a participant in the hangout starts running this app.
   * The argument to the callback is an [ParticipantsEnabledEvent] that holds the set of participants who have started running this app since the last time the event fired.
   */
  ManyEventHandler get onParticipantsEnabled => _onParticipantsEnabled;
  
  /**
   * Handles callbacks to be called whenever participants leave the hangout.
   * The argument to the callback is an [ParticipantsRemovedEvent] that holds the participants who have left since the last time the event fired.
   */
  ManyEventHandler get onParticipantsRemoved => _onParticipantsRemoved;
  
  /**
   * Handles callbacks to be called when the hangout's preferred locale changes.
   */
  ManyEventHandler get onPreferredLocaleChanged => _onPreferredLocaleChanged;
  
  /**
   * Handles callbacks to be called when the hangout becomes public. A hangout can change only from private to public.
   */
  ManyEventHandler get onPublicChanged => _onPublicChanged;
  
  /**
   * Handles callbacks to be called when the hangout topic changes.
   */
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
  
  /// Gets the participants who are running the app.
  List<Participant> getEnabledParticipants() {
    var data = makeProxyCall(["getEnabledParticipants"]);
    var participants = new List<Participant>();
    js.scoped(() {
      for (var i = 0; i < data.length; i++) {
        var proxy = data[i];
        if (proxy != null) participants.add(new Participant._internal(proxy));
      }
      js.release(data);
    });
    return participants;
  }
  
  /**
   * Gets the URL for the hangout.
   * Example URL: 'https://talkgadget.google.com/hangouts/_/1b8d9e10742f576bc994e18866ea'
   */
  String getHangoutUrl() => makeStringCall(["getHangoutUrl"]);
  
  /**
   * Gets an identifier for the hangout guaranteed to be unique for the hangout's duration.
   * The API makes no other guarantees about this identifier.
   * Example of hangout ID: 'muvc-private-chat-99999a93-6273-390d-894a-473226328d79@groupchat.google.com'
   */
  String getHangoutId() => makeStringCall(["getHangoutId"]);

  /**
   * Gets the locale for the local participant.
   * Example: 'en'
   */
  String getLocalParticipantLocale() => makeStringCall(["getLocalParticipantLocale"]);
  
  /**
   * Gets the preferred locale for the hangout. The user can set this locale prior to starting a hangout.
   * It may differ from gapi.hangout.getLocalParticipantLocale.
   * Example: 'en'
   */
  String getPreferredLocale() => makeStringCall(["getPreferredLocale"]);
  
  /**
   * Gets the starting data for the current active app.
   * This is the data passed in by the gd URL parameter.
   * Returns null if no start data has been specified.
   */
  String getStartData() => makeStringCall(["getStartData"]);
  
  /// Gets the [Participant] with the given [participantId]. Returns null if no participant exists with the given ID.
  Participant getParticipantById(String participantId) {
    var data = makeProxyCall(["getLocalParticipant"], [participantId]);
    var participant = null;
    js.scoped(() {
      if (data != null) participant = new Participant._internal(data);
      js.release(data);
    });
    return participant;
  }
  
  /// Gets the local [Participant].
  Participant getLocalParticipant() {
    var data = makeProxyCall(["getLocalParticipant"]);
    var participant = null;
    js.scoped(() {
      if (data != null) participant = new Participant._internal(data);
      js.release(data);
    });
    return participant;
  }
  
  /**
   * Gets the ID of the local participant. A user is assigned a new ID each time they join a hangout.
   * Example: 'hangout65A4C551_ephemeral.id.google.com^354e9d1ed0'
   */
  String getLocalParticipantId() => makeStringCall(["getLocalParticipantId"]);
  
  /**
   * Gets the participants in the hangout. Note that the list of participants reflects the current state on the hangouts server.
   * There can be a small window of time where the local participant is not in the returned array.
   */
  List<Participant> getParticipants() {
    var data = makeProxyCall(["getParticipants"]);
    var participants = new List<Participant>();
    js.scoped(() {
      for (var i = 0; i < data.length; i++) {
        var proxy = data[i];
        if (proxy != null) participants.add(new Participant._internal(proxy));
      }
      js.release(data);
    });
    return participants;
  }
  
  /// Returns the current hangout topic, or an empty string if a topic was not specified.
  String getTopic() => makeStringCall(["getTopic"]);
  
  /// Sets the app as not visible in the main hangout window. The app will continue to run while it is hidden.
  void hideApp() => makeVoidCall(["hideApp"]);
  
  /**
   * Returns true if the gapi.hangout API is initialized; false otherwise.
   * Before the API is initialized, data values might have unexpected values.
   */
  bool isApiReady() => makeBoolCall(["isApiReady"]);
  
  /// Returns true if the app is visible in the main hangout window, false otherwise.
  bool isAppVisible() => makeBoolCall(["isAppVisible"]);
  
  /// Returns true if the hangout is open to the public, false otherwise.
  bool isPublic() => makeBoolCall(["isPublic"]);
}


/// A Participant instance represents a person who has joined a Google hangout.
class Participant {
  
  /**
   * A string uniquely identifying this participant in the hangout.
   * It is not suitable for display to the user. Each time a user joins a hangout, they are assigned a new participant ID.
   * This ID is used to identify a participant throughout the API.
   * Example: 'hangout65A4C551_ephemeral.id.google.com^354e9d1ed0'
   */
  String id;
  
  /// The index of the participant on the filmstrip, 0-based. Can be null.
  int displayIndex;
  
  /// True if the participant has a microphone installed.
  bool hasMicrophone;
  
  /// True if the participant has a video camera installed.
  bool hasCamera;
  
  /// True if the participant has this app enabled and running in this hangout.
  bool hasAppEnabled;
  
  /// True if the participant is the broadcaster. The broadcaster is the owner of the hangout, but only if it is a Hangout On Air.
  bool isBroadcaster;
  
  /// True if the participant will appear in the Hangout On Air broadcast, if this is a Hangout On Air.
  bool isInBroadcast;
  
  /// The representation of the participant's Google+ person.
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

/// The representation of the participant's Google+ person.
class ParticipantPerson {
  
  /**
   * The Google+ ID uniquely identifying this participant.
   * The Google+ ID will never change for a participant.
   * This ID is not suitable for display to the user. Example: '123456789727111132824'
   */
  String id;
  
  /// The name of the participant, suitable for display to the user.
  String displayName;
  
  /// The representation of the participant's profile photo.
  ParticipantPersonImage image;
  
  ParticipantPerson._internal(js.Proxy data) {
    id = data["id"];
    displayName = data["displayName"];
    if (data["image"] != null) image = new ParticipantPersonImage._internal(data["image"]);
  }
}

/// The representation of the participant's profile photo.
class ParticipantPersonImage {
  
  /**
   * The URL to an image suitable for representing the participant.
   * If the participant has not specified a custom image, then a generic image is provided.
   */
  String url;
  
  ParticipantPersonImage._internal(js.Proxy data) {
    url = data["url"];
  }
}

// ****************************
// Events
// ****************************

/// Contains information about the API becoming ready.
class ApiReadyEvent extends HangoutEvent {
  
  /// Indicates whether the API is ready.
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

/// Contains information about an an app becoming visible in a hangout.
class AppVisibleEvent extends HangoutEvent {
  
  /// Indicates whether the app is visible.
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

/// Contains information about participants running this app.
class EnabledParticipantsChangedEvent extends HangoutEvent {
  
  /// List of all participants who are running this app.
  List<Participant> enabledParticipants;
  
  EnabledParticipantsChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["enabledParticipants"] != null) {
      enabledParticipants = new List();
      for (var i = 0; i < data["enabledParticipants"].length; i++) {
        enabledParticipants.add(new Participant._internal(data["enabledParticipants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onEnabledParticipantsChanged callback");
    }
    js.release(data);
  }
}

/// Contains information about participants who have joined the event.
class ParticipantsAddedEvent extends HangoutEvent {
  
  /// List of the newly added participants.
  List<Participant> addedParticipants;
  
  ParticipantsAddedEvent._internal(js.Proxy data) : super._internal() {
    if (data["addedParticipants"] != null) {
      addedParticipants = new List();
      for (var i = 0; i < data["addedParticipants"].length; i++) {
        addedParticipants.add(new Participant._internal(data["addedParticipants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onParticipantsAdded callback");
    }
    js.release(data);
  }
}

/// Contains information about a change of participants joining or leaving the hangout.
class ParticipantsChangedEvent extends HangoutEvent {
  
  /// List of the participants currently in the hangout.
  List<Participant> participants;
  
  ParticipantsChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["participants"] != null) {
      participants = new List();
      for (var i = 0; i < data["participants"].length; i++) {
        participants.add(new Participant._internal(data["participants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onParticipantsChanged callback");
    }
    js.release(data);
  }
}

/// Contains information about participants who have stopped running this app.
class ParticipantsDisabledEvent extends HangoutEvent {
  
  /// List of the participants that stopped running this app.
  List<Participant> disabledParticipants;
  
  ParticipantsDisabledEvent._internal(js.Proxy data) : super._internal() {
    if (data["disabledParticipants"] != null) {
      disabledParticipants = new List();
      for (var i = 0; i < data["disabledParticipants"].length; i++) {
        disabledParticipants.add(new Participant._internal(data["disabledParticipants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onParticipantsDisabled callback");
    }
    js.release(data);
  }
}

/// Contains information about participants who have started running this app.
class ParticipantsEnabledEvent extends HangoutEvent {
  
  /// List of the participants who started running this app.
  List<Participant> enabledParticipants;
  
  ParticipantsEnabledEvent._internal(js.Proxy data) : super._internal() {
    if (data["enabledParticipants"] != null) {
      enabledParticipants = new List();
      for (var i = 0; i < data["enabledParticipants"].length; i++) {
        enabledParticipants.add(new Participant._internal(data["enabledParticipants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onParticipantsEnabled callback");
    }
    js.release(data);
  }
}

/// Contains information about participants who have left the hangout.
class ParticipantsRemovedEvent extends HangoutEvent {
  
  /// List of the participants who have left the hangout.
  List<Participant> removedParticipants;
  
  ParticipantsRemovedEvent._internal(js.Proxy data) : super._internal() {
    if (data["removedParticipants"] != null) {
      removedParticipants = new List();
      for (var i = 0; i < data["removedParticipants"].length; i++) {
        removedParticipants.add(new Participant._internal(data["removedParticipants"][i]));
      }
    } else {
      throw new HangoutAPIException("Invalid return value in onParticipantsRemoved callback");
    }
    js.release(data);
  }
}

/// Contains information about a change to the hangout's preferred locale.
class PreferredLocaleChangedEvent extends HangoutEvent {
  
  /// Indicates the new preferred locale for the hangout.
  String preferredLocale;
  
  PreferredLocaleChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["preferredLocale"] != null) {
      preferredLocale = data.preferredLocale;
    } else {
      throw new HangoutAPIException("Invalid return value in onPreferredLocaleChanged callback");
    }
    js.release(data);
  }
}

/// Contains information about the hangout becoming open to the public.
class PublicChangedEvent extends HangoutEvent {
  
  /// Indicates whether the hangout is open to the public.
  bool isPublic;
  
  PublicChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["isPublic"] != null) {
      isPublic = data.isPublic;
    } else {
      throw new HangoutAPIException("Invalid return value in onPublicChanged callback");
    }
    js.release(data);
  }
}

/// Contains information about the changing of a hangout topic.
class TopicChangedEvent extends HangoutEvent {
  String topic;
  
  /// The new hangout topic.
  TopicChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["topic"] != null) {
      topic = data.topic;
    } else {
      throw new HangoutAPIException("Invalid return value in onTopicChanged callback");
    }
    js.release(data);
  }
}
