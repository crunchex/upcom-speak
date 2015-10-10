library lib.speak;

import 'dart:io';
import 'dart:async';
import 'dart:isolate';

// UpCom import for a Tab back-end (lib).
import 'package:upcom-api/tab_backend.dart';

part 'src/speak_helper.dart';

class CmdrSpeak extends Panel {
  static final List<String> names = ['upcom-speak', 'UpDroid Speak', 'Speak'];

  static final Map<String, String> filenames = {
    0: 'hello',
    1: 'up1',
    2: 'thanks',
    3: 'helping',
    4: 'friends',
    5: 'back',
    6: 'so-long',
    7: 'enjoy'
  };

  CmdrSpeak(SendPort sp, args) :
  super(CmdrSpeak.names, sp, args) {

  }

  void speakHandler(String s) {
    int fileID = int.parse(s);
    Process.run('mpg123', ['${filenames[fileID]}.mp3'], workingDirectory: panelPath, runInShell: true);
  }

  void dynamicHandler(String s) {
    print('test: $s');
//    Process.run('espeak', [s], workingDirectory: panelPath, runInShell: true);
  }

  void registerMailbox() {
    mailbox.registerMessageHandler('SPEAK', speakHandler);
    mailbox.registerMessageHandler('SPEAK_DYNAMIC', dynamicHandler);
  }

  void cleanup() {

  }
}