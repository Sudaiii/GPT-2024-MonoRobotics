import 'package:flutter/material.dart';
import 'package:robocarrera/ui/main_screen.dart';

class JoystickApp extends StatelessWidget {
  const JoystickApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
    );
  }
}
