library web.speak;

import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

// UpCom import for a Tab front-end (lib).
import 'package:upcom-api/tab_frontend.dart';

class UpDroidSpeak extends PanelController {
  static final List<String> names = ['upcom-speak', 'UpDroid Speak', 'Speak'];

  static List getMenuConfig() {
    List menu = [
      {'title': 'File', 'items': [
        {'type': 'toggle', 'title': 'Close Tab'}]}
    ];
    return menu;
  }

  // Private instance variables.
  DivElement _contentDiv;
  InputElement _inputText;
  ButtonElement _executeSpeakButton;
  List<ButtonElement> _speakButtons;

  UpDroidSpeak() :
  super(UpDroidSpeak.names, getMenuConfig(), 'panels/upcom-speak/speak.css') {

  }

  void setUpController() {
    _contentDiv = new DivElement()
      ..id = '$refName-$id-content-div'
      ..classes.add('$refName-content-div');
    view.content.children.add(_contentDiv);


    DivElement buttonGroup = new DivElement()
      ..classes.add('$refName-button-group');
    _contentDiv.children.add(buttonGroup);

    _inputText = new InputElement();
    buttonGroup.children.add(_inputText);


    _executeSpeakButton = new ButtonElement()
      ..classes.add('$refName-execute');
    buttonGroup.children.add(_executeSpeakButton);

    SpanElement spanText = new SpanElement()
      ..text = 'Speak!';
    _executeSpeakButton.children.add(spanText);

    _speakButtons = [];
    for (int i = 0; i < 8; i++) {
      ButtonElement speakButton = new ButtonElement();
      buttonGroup.children.add(speakButton);

      SpanElement spanText = new SpanElement();
      speakButton.children.add(spanText);

      _speakButtons.add(speakButton);
    }

    _speakButtons[0].children[0].text = 'Oh, hello, everyone!  What a good looking bunch of humans!';
    _speakButtons[1].children[0].text = 'I am a brand new Updroid robot, the first of my kind.';
    _speakButtons[2].children[0].text = 'Thank you for inviting me; I am happy to be here.';
    _speakButtons[3].children[0].text = 'Helping children learn sounds like fun!';
    _speakButtons[4].children[0].text = 'Will you be my friends?';
    _speakButtons[5].children[0].text = 'Great! Then I will be back for sure!';
    _speakButtons[6].children[0].text = 'So long, everyone!  ';
    _speakButtons[7].children[0].text = 'Enjoy Maker Faire!';
  }

  void registerMailbox() {

  }

  void registerEventHandlers() {
    _inputText.onKeyUp.listen((e) {
      if (e.keyCode == KeyCode.ENTER) {
        mailbox.ws.send(new Msg('SPEAK_DYNAMIC', _inputText.value).toString());
      }
    });

    _executeSpeakButton.onClick.listen((e) => mailbox.ws.send(new Msg('SPEAK_DYNAMIC', _inputText.value).toString()));

    for (ButtonElement b in _speakButtons) {
      b.onClick.listen((e) => mailbox.ws.send(new Msg('SPEAK', _speakButtons.indexOf(b).toString()).toString()));
    }

    window.onResize.listen((e) {
    // Maybe call a method to resize the tab's contents.
    });
  }

  Element get elementToFocus => view.content.children[0];

  Future<bool> preClose() {
    Completer c = new Completer();
    c.complete(true);
    return c.future;
  }

  void cleanUp() {

  }
}