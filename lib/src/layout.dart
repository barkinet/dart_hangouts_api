part of hangouts_api;

class HangoutLayout {
  ManyEventHandler _onChatPaneVisible;
  ManyEventHandler _onHasNotice;
 
  /**
   * Handles callbacks to be called when a message is received.
   * The argument to the callback is an object containing the participant ID for the sender and the message.
   */
  ManyEventHandler get onChatPaneVisible => _onChatPaneVisible;
  
  /**
   * Handles callbacks to be called when a new version of the shared state object is received from the server.
   * The parameter to the callback is a [StateChangedEvent].
   * Note that the callback will also be called for changes in the shared state
   * which result from submitDelta calls made from this participant's app.
   */
  ManyEventHandler get onHasNotice => _onHasNotice;
  
  
  HangoutLayout._internal() {
    _onChatPaneVisible = new ManyEventHandler._internal(["layout", "onChatPaneVisible"], HangoutEvent.CHAT_PANE_VISIBLE_EVENT);
    _onHasNotice = new ManyEventHandler._internal(["layout", "onHasNotice"], HangoutEvent.HAS_NOTICE_EVENT);
  }
}





/// Contains information about whether the chat pane is visible.
class ChatPaneVisibleEvent extends HangoutEvent {
  
  /// Indicates whether the chat pane is visible.
  bool isChatPaneVisible;

  ChatPaneVisibleEvent._internal(js.Proxy data) : super._internal() {
    if (data["isChatPaneVisible"] != null) {
      isChatPaneVisible = data.isChatPaneVisible;
    } else {
      throw new HangoutAPIException("Invalid return value in onChatPaneVisible callback");
    }
    js.release(data);
  }
}


/// Contains information about whether a notice is currently displayed.
class HasNoticeEvent extends HangoutEvent {
  
  /// Indicates whether the chat pane is visible.
  bool hasNotice;

  HasNoticeEvent._internal(js.Proxy data) : super._internal() {
    if (data["hasNotice"] != null) {
      hasNotice = data.hasNotice;
    } else {
      throw new HangoutAPIException("Invalid return value in onHasNotice callback");
    }
    js.release(data);
  }
}

/// Contains information about whether a notice is currently displayed.
class DisplayedParticipantChangedEvent extends HangoutEvent {
  
  /// Indicates whether the chat pane is visible.
  String displayedParticipant;

  DisplayedParticipantChangedEvent._internal(js.Proxy data) : super._internal() {
    if (data["displayedParticipant"] != null) {
      displayedParticipant = data.displayedParticipant;
    } else {
      throw new HangoutAPIException("Invalid return value in onDisplayedParticipantChanged callback");
    }
    js.release(data);
  }
}