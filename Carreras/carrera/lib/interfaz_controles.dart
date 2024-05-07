// math y joystick adicionales
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:math';

// main
void main() {
  runApp(const JoystickApp());
}

// Constantes globales para tamaños de widgets
const joystickSize = 170.0;
const actionButtonSize = 80.0;

// Clase principal de la aplicación, define el "MaterialApp"
class JoystickApp extends StatelessWidget {
  const JoystickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Control(),
    );
  }
}

// Widget principal que gestiona el estado de la aplicación
class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

// Estado de la aplicación, controla el estado del joystick y otros elementos
class _ControlState extends State<Control> {
  // Variables de estado para el joystick, modo, y slider
  double _joystickX = 20;
  double _joystickY = 0;
  JoystickMode _joystickMode = JoystickMode.all;
  double _speedSliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    // Construcción del Scaffold que define la interfaz de usuario
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controles'),
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        backgroundColor: Colors.teal,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Columna del Joystick
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                    left: _joystickX,
                    bottom: _joystickY,
                    child: GestureDetector(
                      // Gestión de la interacción con el joystick
                      onPanUpdate: (details) {
                        double dx = details.localPosition.dx - (joystickSize / 2);
                        double dy = details.localPosition.dy - (joystickSize / 2);
                        double maxDistance = 0;

                        // Calcular la distancia desde el centro del joystick
                        double distance = sqrt(dx * dx + dy * dy);

                        if (distance > maxDistance) {
                          dx = (dx / distance) * maxDistance;
                          dy = (dy / distance) * maxDistance;
                        }

                        // Actualizar la posición del joystick en el estado
                        setState(() {
                          _joystickX = dx + (joystickSize / 2);
                          _joystickY = dy + (joystickSize / 2);
                        });
                      },
                      child: Container(
                        width: joystickSize,
                        height: joystickSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(joystickSize / 2),
                        ),
                        // Widget de joystick proporcionado por flutter_joystick
                        child: Joystick(
                          mode: _joystickMode,
                          listener: (details) {
                            // Lógica adicional del joystick si es necesaria

                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Columna de botones de acción y slider
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Botón de acción (flecha hacia arriba)
                  SizedBox(
                    width: actionButtonSize,
                    height: actionButtonSize,
                    child: _buildActionButton(
                      icon: Icons.arrow_circle_up,
                      onPressed: () {
                        print('Subir cambio');
                      },
                    ),
                  ),
                  // Slider para ajustar la velocidad
                  Slider(
                    activeColor: Colors.red,
                    value: _speedSliderValue,

                    onChanged: (newValue) {
                      setState(() {
                        _speedSliderValue = newValue;
                      });
                    },

                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: _speedSliderValue.toStringAsFixed(1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para construir un botón de acción personalizado
  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(actionButtonSize / 2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: actionButtonSize * 0.6,
        ),
      ),
    );
  }
}
