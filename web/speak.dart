library web.your_tab;

// Typical dart built-in imports.
import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

// UpCom import for a Tab front-end (lib).
import 'package:upcom-api/tab_frontend.dart';

/// [UpDroidCamera] is a client-side class that uses the jsmpeg library
/// to render a video stream from a [WebSocket] onto a [_canvasElement].
class UpDroidSpeak extends PanelController {
  /// These names should match what you have in lib/tabinfo.json.
  /// names[0] will be used almost everywhere (filesystem, DOM, identification within UpCom core code, etc.).
  /// names[1] will be used when a full, pretty name is needed - such as within the Shop.
  /// names[2] will be used where space is limited, such as the tab handle title. Single words are best.
  static final List<String> names = ['upcom-speak', 'UpDroid Speak', 'Speak'];

  /// This [List] will populate the Tab menu.
  /// You should probably keep at least File > Close Tab.
  static List getMenuConfig() {
    List menu = [
      {'title': 'File', 'items': [
        {'type': 'toggle', 'title': 'Close Tab'}]}
    ];
    return menu;
  }

  // Private instance variables.


  UpDroidSpeak() :
  super(UpDroidSpeak.names, getMenuConfig(), 'tabs/upcom-speak/speak.css') {

  }

  /// Initial [TabController] setup.
  /// This method is called between registerMailbox() and registerEventHandlers().
  void setUpController() {

  }

  //\/\/ Mailbox Handlers /\/\//

  // Add some methods here that are registered with the [Mailbox] below.


  /// Register handlers for [Mailbox].
  void registerMailbox() {
    //  mailbox.registerWebSocketEvent(EventType.ON_OPEN, 'TAB_READY', _signalReady);
    //  mailbox.registerWebSocketEvent(EventType.ON_MESSAGE, 'DO_SOMETHING', _doSomething);
  }

  //\/\/ Mailbox Handlers /\/\//

  // Add some methods here that are called within registerEventHandlers() below.


  /// Create any event handlers for buttons, regular DOM events, etc.
  void registerEventHandlers() {
    window.onResize.listen((e) {
    // Maybe call a method to resize the tab's contents.
    });
  }

  /// Set the [Element] to focus on when the user clicks within the [TabView] area,
  /// (below the menu).
  Element get elementToFocus => view.content.children[0];

  /// This method can be used to prevent a user from closing this [TabController].
  /// DO NOT abuse this. It should only interrupt the process if is still stuff
  /// that needs to be cleaned up. You can also use the [Future] to delay closing.
  Future<bool> preClose() {
    Completer c = new Completer();
    c.complete(true);
    return c.future;
  }

  /// Final clean up method, called right before the [TabController] is destroyed.
  void cleanUp() {

  }
}