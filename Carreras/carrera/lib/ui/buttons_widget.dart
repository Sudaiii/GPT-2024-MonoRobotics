import 'package:flutter/material.dart';
import 'package:robocarrera/controls/control_controller.dart';

class ButtonsWidget extends StatelessWidget {
  final ControlController controller;

  const ButtonsWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.setActiveButton(3);
            print('Botón 3 presionado');
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
