import 'dart:async';

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
  bool _controlsEnabled = false; // Variable para controlar la habilitación de los controles

  Timer? _timer; // Variable para almacenar el timer

  @override
  void initState() {
    super.initState();
    _checkConnection(); // Verificar conexión al iniciar
    _startPeriodicCheck(); // Iniciar verificación periódica
  }

  void _startPeriodicCheck() {
    const checkInterval = Duration(seconds: 2); // Intervalo de verificación

    _timer = Timer.periodic(checkInterval, (timer) {
      _checkConnection(); // Llamar a la función de verificación de conexión
    });
  }

  _checkConnection() async {
    bool isConnected = widget.manager.isConnected;
    setState(() {
      _controlsEnabled = isConnected;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el timer al destruir el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade50,
      child: _controlsEnabled ? buildControls() : buildNoConnectionMessage(),
    );
  }

  Widget buildControls() {
    return Row(
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
                      color: Colors.black,
                      selectedColor: Colors.black87,
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
                borderRadius: BorderRadius.circular(20),
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
    );
  }

  Widget buildNoConnectionMessage() {
    return Center(
      child: Text('Conéctese a un dispositivo para habilitar los controles.'),
    );
  }
}

