import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:robocarrera/controls/joystick_controller.dart';
import 'joystick_widget.dart';
import 'buttons_widget.dart';
import 'dpad_widget.dart';
import 'package:robocarrera/bluetooth/manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Control extends StatefulWidget {
  final BluetoothManager manager;

  Control({Key? key, required this.manager}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  final JoystickControllerNotifier _controller = JoystickControllerNotifier();
  bool _isDPadSelected = true;

  @override
  void initState() {
    super.initState();
    _controller.manager = widget.manager;
    _controller.addListener(() {
      setState(() {});
    });
    _loadSelectedButtonIndex(); // Cargar el estado del botón seleccionado al iniciar
  }

  _loadSelectedButtonIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? selectedButtonIndex = prefs.getInt('selected_button_index');
    if (selectedButtonIndex != null) {
      setState(() {
        _isDPadSelected = selectedButtonIndex == 0;
      });
    }
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
      color: Colors.orange.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Stack(
                children: [
                  _isDPadSelected
                      ? DPad(onDirectionChanged: _controller.onDPadDirectionChanged)
                      : JoystickWidget(controller: _controller),
                  Positioned(
                    top: 0,
                    right: 120,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ToggleButtons(
                        isSelected: [_isDPadSelected, !_isDPadSelected],
                        onPressed: (int index) async {
                          setState(() {
                            _isDPadSelected = index == 0;
                            HapticFeedback.vibrate();
                          });

                          // Guardar el índice del botón presionado en las preferencias compartidas
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('selected_button_index', index);
                        },
                        color: Colors.black, // Color del texto cuando no está seleccionado
                        selectedColor: Colors.black87, // Color del texto cuando está seleccionado
                        borderRadius: BorderRadius.circular(20),
                        fillColor: Colors.orange.shade200,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('DPad'),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Joystick'),
                          ),
                        ],
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Radio del borde
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.orange[100],
                    child: ButtonsWidget(controller: _controller, manager: widget.manager),
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
