import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:robocarrera/controls/joystick_controller.dart';

import 'package:robocarrera/bluetooth/manager.dart';
class ButtonsWidget extends StatefulWidget {
  final JoystickControllerNotifier controller;
  final BluetoothManager manager;

  const ButtonsWidget({
    Key? key,
    required this.controller,
    required this.manager
  }) : super(key: key);

  @override
  _ButtonsWidgetState createState() => _ButtonsWidgetState();
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  late JoystickControllerNotifier _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _loadActiveButton();
  }

  Future<void> _loadActiveButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? activeButton = prefs.getInt('activeButton');
    if (activeButton != null) {
      setState(() {
        _controller.setActiveButton(activeButton);
      });
    }
  }

  Future<void> _saveActiveButton(int button) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('activeButton', button);
  }

  void _onButtonPressed(int button) {
    _controller.setActiveButton(button);
    _saveActiveButton(button);
    print('Botón $button presionado');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.setActiveButton(3);
            print('Botón 3 presionado');
            manager.message("S220\n");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _controller.activeButton == 3 ? Colors.red : Colors.black26,
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
            controller.setActiveButton(2);
            print('Botón 2 presionado');
            manager.message("S170\n");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _controller.activeButton == 2 ? Colors.lightBlueAccent : Colors.black26,
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
            controller.setActiveButton(1);
            print('Botón 1 presionado');
            manager.message("S120\n");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _controller.activeButton == 1 ? Colors.pinkAccent : Colors.black26,
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
    );
  }
}
