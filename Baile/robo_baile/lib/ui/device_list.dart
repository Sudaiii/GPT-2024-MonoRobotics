import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:robobaile/bluetooth/device.dart';
import 'package:robobaile/bluetooth/manager.dart';

class DeviceList extends StatefulWidget {
  final List<Device> devices = [];
  final BluetoothManager manager;

  DeviceList({Key? key, required this.manager}) : super(key: key);

  static int selected = -1;

  @override
  _DeviceList createState() => _DeviceList();
}

class _DeviceList extends State<DeviceList> {
  Future _getDevices() async {
    List<BluetoothDevice> devices = await widget.manager.listDevices();
    for (BluetoothDevice device in devices) {
      String name = device.name ?? "Unknown Device";
      widget.devices.add(Device(name: name, address: device.address));
    }
    setState(() {
      widget.devices.length;
    });
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
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: item.buildTitle(context),
              subtitle: item.buildsubTitle(context),
              onTap: () {
                DeviceList.selected = index;
                widget.manager.connect(items[index].address);
              },
            );
          },
        ),
      ),
    );
  }
}