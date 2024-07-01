// bluetooth/device.dart
import 'package:flutter/cupertino.dart';

class Device {
  String name;
  String address;

  Device({required this.name, required this.address});

  Widget buildTitle(BuildContext context) => Text(address);
  Widget buildsubTitle(BuildContext context) => Text(name);
}