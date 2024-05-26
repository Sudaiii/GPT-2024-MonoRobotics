import 'dart:convert' show utf8;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';


class BluetoothManager {
  BluetoothConnection? _connection;
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
      print('Connected to $address');
      List<int> list = "L100".codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      _connection?.output.add(bytes);
      await _connection?.output.allSent;
    } catch (error) {
      print('Error connecting to device: $error');
    }
  }

  Future<void> message(String message) async {
    if (_connection?.isConnected ?? false) {
      print(message);
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

