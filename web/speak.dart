library web.speak;

// Typical dart built-in imports.
import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

// UpCom import for a Tab front-end (lib).
import 'package:upcom-api/tab_frontend.dart';

/// [UpDroidCamera] is a client-side class that uses the jsmpeg library
/// to render a video stream from a [WebSocket] onto a [_canvasElement].
class UpDroidSpeak extends PanelController {
  /// These names should match what you have in lib/panelinfo.json.
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
  DivElement _contentDiv;
  InputElement _textInput;
  List<ButtonElement> _speakButtons;

  UpDroidSpeak() :
  super(UpDroidSpeak.names, getMenuConfig(), 'panels/upcom-speak/speak.css') {

  }

  /// Initial [TabController] setup.
  /// This method is called between registerMailbox() and registerEventHandlers().
  void setUpController() {
    _contentDiv = new DivElement()
      ..id = '$refName-$id-content-div'
      ..classes.add('$refName-content-div');
    view.content.children.add(_contentDiv);

    DivElement buttonGroup = new DivElement()
      ..classes.add('upcom-speak-button-group');
    _contentDiv.children.add(buttonGroup);

    _speakButtons = [];
    for (int i = 0; i < 8; i++) {
      ButtonElement speakButton = new ButtonElement();
      buttonGroup.children.add(speakButton);
      _speakButtons.add(speakButton);
    }

    _speakButtons[0].text = 'Oh, hello, everyone!  What a good looking bunch of humans!';
    _speakButtons[1].text = 'I am a brand new Updroid robot, the first of my kind.';
    _speakButtons[2].text = 'Thank you for inviting me; I am happy to be here.';
    _speakButtons[3].text = 'Helping children learn sounds like fun!';
    _speakButtons[4].text = 'Will you be my friends?';
    _speakButtons[5].text = 'Great! Then I will be back for sure!';
    _speakButtons[6].text = 'So long, everyone!  ';
    _speakButtons[7].text = 'Enjoy Maker Faire!';
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
    for (ButtonElement b in _speakButtons) {
      b.onClick.listen((e) => mailbox.ws.send(new Msg('SPEAK', _speakButtons.indexOf(b).toString()).toString()));
    }

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