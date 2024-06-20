import 'package:flutter/material.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../bluetooth/device.dart';
import '../bluetooth/manager.dart';

class DeviceList extends StatefulWidget {
  final List<Device> devices = [];
  final BluetoothManager manager;

  DeviceList({Key? key, required this.manager}) : super(key: key);

  static int selected = -1;

  @override
  _SongList createState() => _SongList();
}

class _SongList extends State<DeviceList>{
  // Fills list with songs, based on app configuration/memory
  Future _getDevices() async {
    List<BluetoothDevice> devices = await widget.manager.listDevices();
    for (BluetoothDevice device in devices){
      String name = "Unknown Device";
      if (device.name != null){
        name = device.name as String;
      }
      widget.devices.add(Device(name: name, address: device.address));
    }
    setState(() {widget.devices.length;});
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
                subtitle: item.buildsubTitle(context),
                onTap: () {
                  DeviceList.selected = index;
                  widget.manager.connect(items[index].address);
                }
            );
          },
        ),
      ),
    );
  }
}
