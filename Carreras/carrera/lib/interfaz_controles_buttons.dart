import 'package:flutter/material.dart';

void main() {
  runApp(const JoystickApp());
}

class JoystickApp extends StatelessWidget {
  const JoystickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Control(),
      theme: ThemeData(
        // Define el color de fondo global de la aplicación
        scaffoldBackgroundColor: Colors.grey[270],
      ),
    );
  }
}

class Control extends StatelessWidget {
  const Control({Key? key}) : super(key: key);

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
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Lógica para manejar el botón de configuración
              print('Configuración');
            },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Botones en la parte izquierda de la pantalla
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {

                        print('Botón superior izquierdo');
                      },
                      child: const Text(
                        '^',
                        style: TextStyle(fontSize: 60, color: Colors.black),
                        selectionColor: Colors.blue,
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para el botón izquierdo
                        print('Botón izquierdo');
                      },
                      child: const Text(
                        '<',
                        style: TextStyle(fontSize: 60, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para el botón central
                        print('Botón central');
                      },
                      child: const Text(
                        'O',
                        style: TextStyle(fontSize: 60, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para el botón derecho
                        print('Botón derecho');
                      },
                      child: const Text(
                        '>',
                        style: TextStyle(fontSize: 60, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Lógica para el botón inferior izquierdo
                        print('Botón inferior izquierdo');
                      },
                      child: const Text(
                        'v',
                        style: TextStyle(fontSize: 60, color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Todo lo del lado derecho: (Boton de aceleracion)
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Utilizar Ink para envolver el IconButton y definir el color de fondo **
                Ink(
                  decoration: ShapeDecoration(
                    color: Colors.black, // Color de fondo del boton
                    shape: CircleBorder(), // Forma del contorno del botón
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Lógica para el botón de aceleracion
                      print('Botón derecho');
                    },
                    icon: const Icon(Icons.arrow_upward_rounded),
                    iconSize: 100.0,
                    tooltip: 'Acelerar',
                    color:
                        Colors.white, // Color del icono
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
