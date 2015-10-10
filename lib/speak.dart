library lib.speak;

// Typical dart built-in imports.
import 'dart:io';
import 'dart:async';
import 'dart:isolate';

// UpCom import for a Tab back-end (lib).
import 'package:upcom-api/tab_backend.dart';

// Other parts of your back-end.
part 'src/speak_helper.dart';

/// This is the main class that should encapsulate most of your code.
/// If it does grow sufficiently large, then it will at least be your entry point.
/// [CmdrSpeak] will be instantiated in bin/main.dart.
class CmdrSpeak extends Panel {
  /// These names should match what you have in lib/panelinfo.json.
  /// names[0] will be used almost everywhere (filesystem, DOM, identification within UpCom core code, etc.).
  /// names[1] will be used when a full, pretty name is needed - such as within the Shop.
  /// names[2] will be used where space is limited, such as the tab handle title. Single words are best.
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

  // Private instance variables.
  //  int _x;
  //  String _y;

  CmdrSpeak(SendPort sp, args) :
  super(CmdrSpeak.names, sp, args) {
    // Don't put expensive, time-consuming code here.
    // Set up a call to an async function, or save more
  }

  void speakHandler(String s) {
    int fileID = int.parse(s);
    Process.run('mpg123', ['${filenames[fileID]}.mp3'], workingDirectory: panelPath, runInShell: true);
  }

  void dynamicHandler(String s) {
    print('test: $s');
//    Process.run('espeak', [s], workingDirectory: panelPath, runInShell: true);
  }

  /// Register message handlers as part of the setup routine.
  void registerMailbox() {
    // Register message handlers for incoming String messages.
    mailbox.registerMessageHandler('SPEAK', speakHandler);

    mailbox.registerMessageHandler('SPEAK_DYNAMIC', dynamicHandler);

    // Register endpoint handlers for direct websocket connections. These are more useful for
    // cases where there is a lot of data (like a video stream), or when a pre-existing application
    // requires a direct endpoint.
    //  mailbox.registerEndPointHandler('/$refName/$id/websocket_endpoint', _endpointHandler);
  }

  /// Called last, right before the [Tab] is destroyed.
  void cleanup() {
  //  if (_shell != null) _shell.kill();
  }

}