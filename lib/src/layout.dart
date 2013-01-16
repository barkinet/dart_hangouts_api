part of hangouts_api;

class HangoutLayout {
  ManyEventHandler _onChatPaneVisible;
  ManyEventHandler _onHasNotice;
 
  VideoCanvas _videoCanvas;
  DefaultVideoFeed _defaultVideoFeed;
  Map<String, VideoFeed> _participantVideoFeeds;
  
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
    _participantVideoFeeds = new Map();
  }
  
  /// Creates a video feed that displays only a given participant.
  VideoFeed createParticipantVideoFeed(String participantId) {
    if (_participantVideoFeeds[participantId] == null) {
      var data = _makeProxyCall(["layout", "createParticipantVideoFeed"], [participantId]);
      _participantVideoFeeds[participantId] = new VideoFeed._internal(data);
    }
    return _participantVideoFeeds[participantId];
  }
  
  /// Dismisses the currently displayed notice.
  void dismissNotice() => _makeVoidCall(["layout", "dismissNotice"]);
  
  /// Displays a notice at the top of the hangout window.
  void displayNotice(String message, [bool opt_permanent]) {
    if (?opt_permanent && opt_permanent != null) {
      _makeVoidCall(["layout", "displayNotice"], [message, opt_permanent]);
    } else {
      _makeVoidCall(["layout", "displayNotice"], [message]);
    }
  }
  
  /// Returns the [DefaultVideoFeed]
  DefaultVideoFeed getDefaultVideoFeed() {
    if (_defaultVideoFeed == null) {
      var data = _makeProxyCall(["layout", "getDefaultVideoFeed"]);
      _defaultVideoFeed = new DefaultVideoFeed._internal(data);
    }
    return _defaultVideoFeed;
  }
  
  /// Returns the [VideoCanvas], initially set to the default video feed.
  VideoCanvas getVideoCanvas() {
    if (_videoCanvas == null) {
      var data = _makeProxyCall(["layout", "getVideoCanvas"]);
      _videoCanvas = new VideoCanvas._internal(getDefaultVideoFeed(), data);
    }
    return _videoCanvas;
  }
  
  /// Returns true if a notice is currently being displayed, false otherwise.
  bool hasNotice() => _makeBoolCall(["layout", "hasNotice"]);
  
  /// Returns true if a chat pane is visible, false otherwise.
  bool isChatPaneVisible() => _makeBoolCall(["layout", "isChatPaneVisible"]);
  
  /// Shows or hides the chat pane.
  void setChatPaneVisible(bool visible) => _makeVoidCall(["layout", "setChatPaneVisible"], [visible]);
}

/**
 * A video feed which can be displayed on the [VideoCanvas].
 * A video feed can either show a participant, by using createParticipantVideoFeed,
 * or the active speaker, by using getDefaultVideoFeed.
 */
abstract class AbstractVideoFeed extends ProxyObject {
  
  AbstractVideoFeed._internal(js.Proxy proxy) : super._internal(proxy);
}

/// The normal video feed with standard Hangouts participant selection showing the active speaker.
class DefaultVideoFeed extends AbstractVideoFeed {
  
  ManyEventHandler _onDisplayedParticipantChanged;
  
  /**
   * Handles callback to be called when the displayed participant changes.
   * The argument to the callback is an [DisplayedParticipantChangedEvent] that holds the ID of the new displayed participant.
   * Note that these events will fire even when the canvas is not showing the DefaultVideoFeed.
   */
  ManyEventHandler get onDisplayedParticipantChanged => _onDisplayedParticipantChanged;
  
  DefaultVideoFeed._internal(js.Proxy proxy) : super._internal(proxy) {
    _onDisplayedParticipantChanged = new ManyEventHandler._internalProxy(_proxy, HangoutEvent.DISPLAYED_PARTICIPANT_CHANGED_EVENT);
  }

}

/// A participant video feed only showing this participant
class VideoFeed extends AbstractVideoFeed {
  
  VideoFeed._internal(js.Proxy proxy) : super._internal(proxy);
  
  /**
   * Gets the participant ID of the participant who is displayed in this video feed.
   * Example: 'hangout65A4C551_ephemeral.id.google.com^354e9d1ed0'
   */
  String getDisplayedParticipant() => js.scoped(() => _proxy.getDisplayParticipant());
}

/**
 * A canvas on which a [VideoFeed] renders. Each hangout has a single VideoCanvas instance.
 * The video canvas displays in front of the app and cannot have other HTML elements in front of it.
 * Get the VideoCanvas object with getVideoCanvas.
 */
class VideoCanvas extends ProxyObject {
  
  AbstractVideoFeed _videoFeed;
  
  VideoCanvas._internal(DefaultVideoFeed this._videoFeed, js.Proxy proxy) : super._internal(proxy);
  
  /// Returns the aspect ratio of the canvas.
  num getAspectRatio() => js.scoped(() => _proxy.getAspectRatio());
  
  /// Gets the height of the video canvas, in pixels.
  num getHeight() => js.scoped(() => _proxy.getHeight());
  
  /** 
   * Returns the position of the video canvas.
   * {left: number, top: number}
   */
  Map<String, num> getPosition() {
    var data, position;
    js.scoped(() { 
      data = _proxy.getPosition();
      if (data != null) position = JSON.parse(js.context.JSON.stringify(data));
    });
    return position;
  }
  
  /**
   *  Returns the size of the video canvas.
   *  {width: number, height: number}
   */
  Map<String, num> getSize() {
    var data, size;
    js.scoped(() { 
      data = _proxy.getSize();
      if (data != null) size = JSON.parse(js.context.JSON.stringify(data));
    });
    return size;
  }
  
  /// Gets the width of the video canvas, in pixels.
  num getWidth() => js.scoped(() => _proxy.getWidth());
  
  /// Returns the video feed being shown on this canvas.
  AbstractVideoFeed getVideoFeed() => _videoFeed;
  
  /// Returns true if the video canvas is visible, false otherwise.
  bool isVisible() => js.scoped(() => _proxy.isVisible());
  
  /**
   * Sets the height of the canvas, in pixels. The width will automatically be set based on the aspect ratio of the canvas.
   * Returns the new size of the video canvas. {width: number, height: number}
   */
  Map<String, num> setHeight(num height) {
    var data, size;
    js.scoped(() { 
      data = _proxy.setHeight(height);
      if (data != null) size = JSON.parse(js.context.JSON.stringify(data));
    });
    return size;
  }
  
  /**
   * Sets the position of the video canvas, in pixels, from the top left corner of the app.
   * 
   * value : number|{left: number, top: number}
   * Either a single number representing the left offset, or an object with the top and left offsets.
   * 
   * opt_top : number
   * The top offset. (This parameter is ignored if value is an object.)
   */
  void setPosition(value, [num opt_top]) {
    if (value is! num && value is! Map<String, num>) {
      throw(new ArgumentError("value has be be num or Map<String, num>"));
      return;
    }
    if (value is num) {
      if(?opt_top && opt_top != null) {
        js.scoped(() => _proxy.setPosition(value, opt_top));
      } else {
        throw(new ArgumentError("If value is num, opt_top has to be set as well"));
      }
    } else {
      js.scoped(() => _proxy.setPosition(_createParamProxy(value)));
    }
  }
  
  /// Sets which video feed is being shown on this canvas.
  void setVideoFeed(AbstractVideoFeed videoFeed) {
    _videoFeed = videoFeed;
    js.scoped(() => _proxy.setVideoFeed(videoFeed._proxy));
  }
  
  /// Sets the visibility of the video canvas.
  void setVisible(bool visible) => js.scoped(() => _proxy.setVisible(visible));
  
  /**
   * Sets the width of the canvas, in pixels. The height will automatically be set based on the aspect ratio of the canvas.
   * Returns the new size of the video canvas. {width: number, height: number}
   */
  Map<String, num> setWidth(num width) {
    var data, size;
    js.scoped(() { 
      data = _proxy.setWidth(width);
      if (data != null) size = JSON.parse(js.context.JSON.stringify(data));
    });
    return size;
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