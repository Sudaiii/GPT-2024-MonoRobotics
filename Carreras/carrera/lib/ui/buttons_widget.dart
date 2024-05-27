import 'package:flutter/material.dart';
import 'package:robocarrera/controls/joystick_controller.dart';

import 'package:robocarrera/bluetooth/manager.dart';



class ButtonsWidget extends StatelessWidget {
  final JoystickControllerNotifier controller;
  final BluetoothManager manager;

  const ButtonsWidget({
    Key? key,
    required this.controller,
    required this.manager
  }) : super(key: key);

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
            backgroundColor: controller.activeButton == 3 ? Colors.red : Colors.black26,
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
            backgroundColor: controller.activeButton == 2 ? Colors.lightBlueAccent : Colors.black26,
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
            backgroundColor: controller.activeButton == 1 ? Colors.pinkAccent : Colors.black26,
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
