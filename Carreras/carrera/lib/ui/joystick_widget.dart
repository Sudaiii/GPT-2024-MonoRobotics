import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:robocarrera/controls/joystick_controller.dart';

const joystickSize = 200.0;

class JoystickWidget extends StatelessWidget {
  final JoystickControllerNotifier controller;

  const JoystickWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 100,
      bottom: controller.joystickY,
      child: Container(
        width: joystickSize,
        height: joystickSize,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(joystickSize/2),
          border: Border.all(
            color: Colors.orangeAccent,
            width: 2.0,
          ),
        ),
        child: Joystick(
          mode: controller.joystickMode,
          listener: controller.onJoystickMove,
        ),
      ),
    );
  }
}
