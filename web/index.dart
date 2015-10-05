import 'dart:html';
import 'package:quiver/async.dart';
import 'your_tab.dart';

/// Entry point for [YourTab]'s front-end.
void main() {
  // You can load javascript libraries that are located in web.
  // Passing them into your [TabController] allows them to be loaded when it opens,
  // and unloaded when it's closed.
  ScriptElement script1 = new ScriptElement()
    ..type = 'text/javascript'
    ..src = 'tabs/upcom-your-tab/script1.min.js';
  document.body.children.add(script1);

  ScriptElement script2 = new ScriptElement()
    ..type = 'text/javascript'
    ..src = 'tabs/upcom-your-tab/script2.min.js';
  document.body.children.add(script2);

  FutureGroup futureGroup = new FutureGroup();
  futureGroup.add(script1.onLoad.first);
  futureGroup.add(script2.onLoad.first);

  // Instantiate your [TabController] once all the javascript libraries are loaded.
  futureGroup.future.then((_) {
    new YourTabController([script1, script2]);
  });
}