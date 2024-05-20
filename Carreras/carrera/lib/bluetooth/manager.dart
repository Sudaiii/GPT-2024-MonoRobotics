import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';


class BluetoothManager {
  late BluetoothConnection _connection;
  late List<BluetoothDevice> devices;

  BluetoothManager(){
    _requestPermissionBluetoothScan();
    _requestPermissionBluetoothConnect();
    listDevices();
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


  Future<void> connect(String address) async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    try {
      _connection = await BluetoothConnection.toAddress(address);
      print('Connected to ${address}');
    } catch (error) {
      print('Error connecting to device: $error');
    }
  }

}

