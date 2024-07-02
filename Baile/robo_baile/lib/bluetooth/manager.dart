
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothManager {
  BluetoothConnection? _connection;
  late List<BluetoothDevice> devices;

  BluetoothManager() {
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.bluetooth,

      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
  }

  Future<List<BluetoothDevice>> listDevices() async {
    // Solicitar permisos
    if (await Permission.bluetoothConnect.request().isGranted) {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } else {
      devices = [];
    }
    return devices;
  }

  Future<void> connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
      print('Connected to $address');
    } catch (error) {
      print('Error connecting to device: $error');
    }
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
