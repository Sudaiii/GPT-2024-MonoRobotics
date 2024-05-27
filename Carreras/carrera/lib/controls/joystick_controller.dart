import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter/material.dart';

import 'package:robocarrera/bluetooth/manager.dart';



class JoystickControllerNotifier extends ChangeNotifier {
  double joystickX = 20;
  double joystickY = 0;
  final JoystickMode joystickMode = JoystickMode.all;
  int activeButton = 0;
  late BluetoothManager manager;

  void onJoystickMove(StickDragDetails details) {
    double x = details.x;
    double y = details.y;
    int speedX = (x * 255).toInt();
    int speedY = (y * 255).toInt();
    print("X$speedX""Y$speedY\n");
    manager.message("X$speedX""Y$speedY\n");
  }

  void setActiveButton(int buttonIndex) {
    activeButton = buttonIndex;
    notifyListeners();
  }
}
