import 'package:flutter/material.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:robocarrera/bluetooth/device.dart';


class DeviceList extends StatefulWidget {
  List<Device> devices = [];

  DeviceList({super.key});

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}


class _SongList extends State<DeviceList>{

  // Fills list with songs, based on app configuration/memory
  Future _getDevices() async {
    _requestPermissionBluetoothScan();
    _requestPermissionBluetoothConnect();

    List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();

    for (BluetoothDevice device in devices){
      String name = "Unknown Device";
      if (device.name != null){
        name = device.name as String;
      }
      widget.devices.add(Device(name: name, address: device.address));
    }

    widget.devices.add(
      Device(
          name: 'teeest1',
          address: '123',
      )
    );
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

  @override
  void initState() {
    super.initState();
    if (widget.devices.isEmpty) {
      _getDevices();
    }
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Lista Dispositivos';

    final items = widget.devices;

    return MaterialApp(
      title: title,
      home: Scaffold(
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
                title: item.buildTitle(context),
                subtitle: item.buildSubtitle(context),
                onTap: () {
                  DeviceList.selected = index;
                  //play_selected(index)
                }
            );
          },
        ),
      ),
    );
  }
}
