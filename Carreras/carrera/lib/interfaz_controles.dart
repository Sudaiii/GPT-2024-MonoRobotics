import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:math';

void main() {
  runApp(const JoystickApp());
}

const joystickSize = 170.0;
const actionButtonSize = 80.0;

class JoystickApp extends StatelessWidget {
  const JoystickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Control(),
    );
  }
}

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double _joystickX = 20;
  double _joystickY = 0;
  double _joystickX2 = 20;
  double _joystickY2 = 0;
  JoystickMode _joystickMode = JoystickMode.all;
  JoystickMode _joystickMode_vel = JoystickMode.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controles'),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        backgroundColor: Colors.teal,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                    left: _joystickX,
                    bottom: _joystickY,

                      child: Container(
                        width: joystickSize,
                        height: joystickSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(joystickSize / 2),
                        ),
                        child: Joystick(
                          mode: _joystickMode,
                          listener: (details) {
                            // Additional logic for the first joystick if needed
                          },
                        ),
                      ),
                    ),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                    left: _joystickX2,
                    bottom: _joystickY2,

                      child: Container(
                        width: joystickSize,
                        height: joystickSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(joystickSize / 2),
                        ),
                        child: Joystick(
                          mode: _joystickMode_vel,
                          listener: (details) {
                            // Additional logic for the second joystick if needed
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}