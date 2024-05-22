import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'ui/joystick_app.dart';

void main() {
  runApp(const JoystickApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
