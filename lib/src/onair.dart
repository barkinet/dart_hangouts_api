part of hangouts_api;

/// Provides ability for interacting with Hangouts On Air.
class HangoutOnair {

  ManyEventHandler _onBroadcastingChanged;
  ManyEventHandler _onNewParticipantInBroadcastChanged;
  OnceEventHandler _onYouTubeLiveIdReady;
  
  /// Handles callbacks to be called when the hangout starts or stops broadcasting.
  ManyEventHandler get onBroadcastingChanged => _onBroadcastingChanged;
  
  /// Handles callbacks to be called when the setting changes for whether new participants are in the Hangout On Air by default.
  ManyEventHandler get onNewParticipantInBroadcastChanged => _onNewParticipantInBroadcastChanged;
  
  /// Handles callbacks to be called when the YouTube Live ID is set for a Hangout On Air.
  OnceEventHandler get onYouTubeLiveIdReady => _onYouTubeLiveIdReady;
  
  HangoutOnair._internal() {
    _onBroadcastingChanged = new ManyEventHandler._internal(["onair", "onBroadcastingChanged"], HangoutEvent.CHAT_PANE_VISIBLE_EVENT);
    _onNewParticipantInBroadcastChanged = new ManyEventHandler._internal(["onair", "onNewParticipantInBroadcastChanged"], HangoutEvent.CHAT_PANE_VISIBLE_EVENT);
    _onYouTubeLiveIdReady = new OnceEventHandler._internal(["onair", "onYouTubeLiveIdReady"], HangoutEvent.CHAT_PANE_VISIBLE_EVENT);
  }
  
  /**
   * Returns the YouTube Live ID for the Hangout On Air.
   * Returns null if the ID is not available or the hangout is not a broadcast hangout.
   */
  String getYouTubeLiveId() => _makeStringCall(["onair", "getYouTubeLiveId"]);

  /// Returns true if the hangout is a Hangout On Air which is currently broadcasting, false otherwise.
  bool isBroadcasting() => _makeBoolCall(["onair", "isBroadcasting"]);
  
  /// Returns true if new participants to the hangout are included in the Hangout On Air broadcast by default, false otherwise.
  bool isNewParticipantInBroadcast() => _makeBoolCall(["onair", "isNewParticipantInBroadcast"]);
  
  /**
   * Returns true if the hangout is a Hangout On Air, false otherwise.
   * Note that this does not indicate that the hangout is currently broadcasting — see isBroadcasting for that.
   * This value may change from false to true when the YouTubeLiveIdReady event fires.
   */
  bool isOnAirHangout() => _makeBoolCall(["onair", "isOnAirHangout"]);
  
  /**
   * Sets whether the given participant is included in the Hangout On Air broadcast.
   * This call fails for hangouts that are not On Air, or if the local participant is not the broadcaster of the hangout.
   */
  void setParticipantInBroadcast(String participantId, bool isInBroadcast) => _makeVoidCall(["onair", "setParticipantInBroadcast"], [participantId, isInBroadcast]);
  
  /**
   * Sets whether new participants in the hangout are included in the Hangout On Air broadcast by default.
   * This call fails for hangouts that are not On Air, or if the local participant is not the broadcaster of the hangout.
   */
  void setNewParticipantInBroadcast(bool isInBroadcast) => _makeVoidCall(["onair", "setNewParticipantInBroadcast"], [isInBroadcast]);
}


/// Contains information about whether the hangout is broadcasting.
class BroadcastingChangedEvent extends HangoutEvent {
  
  /// Indicates whether the hangout is broadcasting.
  bool isBroadcasting;

  BroadcastingChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["isBroadcasting"] != null) {
      isBroadcasting = data.isBroadcasting;
    } else {
      throw new HangoutAPIException("Invalid return value in onBroadcastingChanged callback");
    }
    js.release(data);
  }
}

/// Contains information about whether new participants will be included in the Hangout On Air broadcast by default.
class NewParticipantInBroadcastChangedEvent extends HangoutEvent {
  
  /// Indicates whether new participants are in the broadcast by default.
  bool isNewParticipantInBroadcast;

  NewParticipantInBroadcastChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["isNewParticipantInBroadcast"] != null) {
      isNewParticipantInBroadcast = data.isNewParticipantInBroadcast;
    } else {
      throw new HangoutAPIException("Invalid return value in onNewParticipantInBroadcastChanged callback");
    }
    js.release(data);
  }
}

/// Contains information signaling the YouTube Live ID for a Hangout On Air is available.
class YouTubeLiveIdReadyEvent extends HangoutEvent {
  
  /// The YouTube Live ID for the Hangout On Air.
  String youTubeLiveId;

  YouTubeLiveIdReadyEvent._internal(js.Proxy data) : super._internal() {
    if (data["youTubeLiveId"] != null) {
      youTubeLiveId = data.youTubeLiveId;
    } else {
      throw new HangoutAPIException("Invalid return value in onYouTubeLiveIdReady callback");
    }
    js.release(data);
  }
}