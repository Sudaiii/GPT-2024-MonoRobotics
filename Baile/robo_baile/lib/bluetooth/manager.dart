import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothManager {
  BluetoothConnection? _connection;
  late List<BluetoothDevice> devices;

  BluetoothManager() {
    requestPermissions();
    listDevices();
  }

  Future<void> requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
  }

  Future<List<BluetoothDevice>> listDevices() async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    return devices;
  }

  Future<void> connect(BuildContext context, String address) async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    try {
      _connection = await BluetoothConnection.toAddress(address);
      print('Connected to $address');
      _showConnectedDialog(context);
    } catch (error) {
      print('Error connecting to device: $error');
    }
  }

  void _showConnectedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Device Paired'),
          content: Text('Successfully connected to the device.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> message(String message) async {
    if (_connection?.isConnected ?? false) {
      List<int> list = message.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _connection?.output.add(bytes);
      await _connection?.output.allSent;
    } else {
      print("Not connected");
    }
  }
}
