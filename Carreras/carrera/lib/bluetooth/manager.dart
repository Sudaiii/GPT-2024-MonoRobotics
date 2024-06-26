import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:robocarrera/bluetooth/bluetooth_listener.dart';



class BluetoothManager {
  BluetoothConnection? _connection;
  bool get isConnected => _connection != null;
  late List<BluetoothDevice> devices;
  late List<BluetoothListener> listeners;

  BluetoothManager(){
    _requestPermissionBluetoothScan();
    _requestPermissionBluetoothConnect();
    listDevices();
    listeners = [];
  }


  Future<void> _requestPermissionBluetoothScan() async {
    final permission = Permission.bluetoothScan;

    if (await permission.isDenied) {
      await permission.request();
    }
  }


  Future<void> _requestPermissionBluetoothConnect() async {
    final permission = Permission.bluetoothConnect;

    if (await permission.isDenied) {
      await permission.request();
    }
  }


  Future<List<BluetoothDevice>> listDevices() async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    return devices;
  }


  void addListener(BluetoothListener listener) {
    listeners.add(listener);
  }

  void disconnectDevice() {
    if (_connection?.isConnected ?? false) {
      _connection?.close();
      _connection?.dispose();
      print("Desconectado");
      for (BluetoothListener listener in listeners) {
        listener.deviceDisconnected();
      }
    }
    else {
      print("Not connected");
    }
  }

  Future<bool> connect(String address) async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    try {
      _connection = await BluetoothConnection.toAddress(address);
      // Set action on device disconnect
      _connection!.input!.listen(null).onDone(() {
        print("Desconectado");
        for (BluetoothListener listener in listeners) {
          listener.deviceDisconnected();
        }
        // Agregar una lista de listeners a los cuales notificar desconexion
      });
      return true;
    } catch (error) {
      print('Error connecting to device: $error');
      return false;
    }
  }

  Future<void> message(String message) async {
    if (_connection?.isConnected ?? false) {
      List<int> list = message.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _connection?.output.add(bytes);
      await _connection?.output.allSent;
    }
    else {
      print("Not connected");
    }

  }
  
}

