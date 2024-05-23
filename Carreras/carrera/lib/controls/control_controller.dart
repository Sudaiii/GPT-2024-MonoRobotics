import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';

class ControlController extends ChangeNotifier {
  double joystickX = 20;
  double joystickY = 0;
  final JoystickMode joystickMode = JoystickMode.all;
  int activeButton = 0;

  void onJoystickMove(StickDragDetails details) {
    double x = details.x;
    double y = details.y;
    int speedX = (x * 255).toInt();
    int speedY = (y * 255).toInt();
    String data = 'X$speedX Y$speedY\n';
    print('Joystick : data: $data');

  }

  void setActiveButton(int buttonIndex) {
    activeButton = buttonIndex;
    notifyListeners();
  }
}
