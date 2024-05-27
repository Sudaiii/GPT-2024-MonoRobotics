import 'package:flutter/material.dart';
import 'package:robocarrera/controls/joystick_controller.dart';
import 'joystick_widget.dart';
import 'buttons_widget.dart';

import 'package:robocarrera/bluetooth/manager.dart';



class Control extends StatefulWidget {
  final BluetoothManager manager;

  Control({Key? key, required this.manager}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  final JoystickControllerNotifier _controller = JoystickControllerNotifier();

  @override
  void initState() {
    super.initState();
    _controller.manager = widget.manager;
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {
      setState(() {});
    });
    super.dispose();
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
                  JoystickWidget(controller: _controller),
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
                  child: ButtonsWidget(controller: _controller, manager: widget.manager),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
