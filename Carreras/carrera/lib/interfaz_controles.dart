import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:math';

void main() {
  runApp(const JoystickApp());
}

const joystickSize = 200.0;

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
  //Posiciones de los Joystcik
  double _joystickX = 20;
  double _joystickY = 0;
  double _joystickX2 = 20;
  double _joystickY2 = 0;
  JoystickMode _joystickMode = JoystickMode.all;
  JoystickMode _joystickMode_vel = JoystickMode.vertical;

  void _handleButtonPress() {
    // Lógica a ejecutar cuando se presiona el botón
    print('Botón presionado');
  }
  void _onJoystickMove(StickDragDetails details) {
    double x = details.x;
    double y = details.y;
    int speedX = (x * 255).toInt(); // Escalamos el valor de -1.0 a 1.0 a -255 a 255
    int speedY = (y * 255).toInt(); // Escalamos el valor de -1.0 a 1.0 a -255 a 255
    String data = 'X$speedX Y$speedY\n';
    //_sendData(data);
    print('Joystick : data: $data');
  }

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
        actions: [
          IconButton(

            icon: Icon(Icons.settings),  // Icono del botón
            onPressed: _handleButtonPress,  // Función que se ejecuta al presionar el botón,
          ),
        ],
      ),
      body: Row(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Stack(
                children: [
                  Positioned(
                    left: 100,
                    bottom: _joystickY,
                    child: Container(
                      width: joystickSize,
                      height: joystickSize,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(joystickSize / 2),
                      ),
                      child: Joystick(
                        mode: _joystickMode,
                        listener: _onJoystickMove,


                        //listener: (details) {
                          // Additional logic for the first joystick if needed

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
              padding: const EdgeInsets.all(50.0),

              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: _joystickY2,
                    child: Container(
                      width: joystickSize,
                      height: joystickSize,
                      decoration: BoxDecoration(
                        color: Colors.black,
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
