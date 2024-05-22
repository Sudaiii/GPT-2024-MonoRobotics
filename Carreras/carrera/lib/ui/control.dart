import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}
const joystickSize = 200.0;

class _ControlState extends State<Control> {
  double _joystickX = 20;
  double _joystickY = 0;
  final JoystickMode _joystickMode = JoystickMode.all;
  int _activeButton = 0;


  void _onJoystickMove(StickDragDetails details) {
    double x = details.x;
    double y = details.y;
    int speedX = (x * 255).toInt();
    int speedY = (y * 255).toInt();
    String data = 'X$speedX Y$speedY\n';
    print('Joystick : data: $data');
  }

  void _setActiveButton(int buttonIndex) {
    setState(() {
      _activeButton = buttonIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Stack(
                children: [
                  Positioned(
                    left: 100,
                    bottom: _joystickY,
                    child: Container(
                      width: joystickSize,
                      height: joystickSize,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(joystickSize / 2),
                        border: Border.all(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                      child: Joystick(
                        mode: _joystickMode,
                        listener: _onJoystickMove,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  color: Colors.grey[300],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _setActiveButton(3);
                          print('Botón 3 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _activeButton == 3? Colors.red : Colors.black26,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _setActiveButton(2);
                          print('Botón 2 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _activeButton == 2? Colors.lightBlueAccent : Colors.black26,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _setActiveButton(1);
                          print('Botón 1 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _activeButton == 1? Colors.pinkAccent : Colors.black26,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
