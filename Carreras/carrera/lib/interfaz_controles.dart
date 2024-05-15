import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';

void main() {
  runApp(const JoystickApp());
}

const joystickSize = 200.0;

class JoystickApp extends StatelessWidget {
  const JoystickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RoboRun',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 20.0,
      ),
      body: Column(
        children: [
          ColoredBox(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.gamepad, color: Colors.black), text: 'Control'),
                Tab(icon: Icon(Icons.settings, color: Colors.black), text: 'Configuración'),
              ],
              labelStyle: TextStyle(fontSize: 14.0),
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.purple,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Control(),
                Configuracion(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  double _joystickX = 20;
  double _joystickY = 0;
  final JoystickMode _joystickMode = JoystickMode.all;

  void _onJoystickMove(StickDragDetails details) {
    double x = details.x;
    double y = details.y;
    int speedX = (x * 255).toInt();
    int speedY = (y * 255).toInt();
    String data = 'X$speedX Y$speedY\n';
    print('Joystick : data: $data');
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
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
                          print('Botón 3 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white, // Cambiar color del texto a blanco
                            fontSize: 18, // Aumentar el tamaño del texto
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Botón 2 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white, // Cambiar color del texto a blanco
                            fontSize: 18, // Aumentar el tamaño del texto
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('Botón 1 presionado');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black26,
                        ),
                        child: const Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white, // Cambiar color del texto a blanco
                            fontSize: 18, // Aumentar el tamaño del texto
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


class Configuracion extends StatelessWidget {
  const Configuracion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text('Configuración', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
