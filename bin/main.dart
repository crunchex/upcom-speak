import 'dart:isolate';
import 'package:upcom-api/tab_backend.dart';
import '../lib/speak.dart';

void main(List args, SendPort interfacesSendPort) {
  Tab.main(interfacesSendPort, args, (port, args) => new CmdrSpeak(port, args));
}