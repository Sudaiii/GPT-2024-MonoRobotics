import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:robocarrera/bluetooth/bluetooth_listener.dart';
import 'package:robocarrera/bluetooth/device.dart';
import 'package:robocarrera/bluetooth/manager.dart';
import 'package:robocarrera/ui/dialog_factory.dart';




class DeviceList extends StatefulWidget{
  final List<Device> devices = [];
  final BluetoothManager manager;

  DeviceList({super.key, required this.manager});

  static int selected = -1;

  @override
  SongList createState() => SongList();
}


class SongList extends State<DeviceList> implements BluetoothListener {
  bool isConnecting = false;

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


  Future __connect(int index) async {
    setState(() {
      isConnecting = true;
    });
    widget.manager.disconnectDevice();
    String address = widget.devices[index].address;
    String name = widget.devices[index].name;

    // Remove ✔️ from previously selected device
    if (DeviceList.selected >= 0) {
      widget.devices[DeviceList.selected].name = widget.devices[DeviceList.selected].name.replaceAll("✔️", "");
    }
    // Flag as "connecting"
    DeviceList.selected = -2;
    // Attempt connection
    bool success = await widget.manager.connect(address);
    if (success) {
      // Add ✔️ to connected device
      widget.devices[index].name = "$name ✔️";
      DeviceList.selected = index;
    }
    else {
      // Deploy dialog
      await showDialog(
          context: context,
          builder: (context) {
            return build_dialog(
                context,
                "Error de conexión",
                "No se ha podido establecer una conexión con el dispositivo $name.",
                "Ok"
            );
          }
      );
      DeviceList.selected = -1;
    }
    setState(() {
      widget.devices.length;
      isConnecting = false;
    });
  }

  @override
  void deviceDisconnected() async {
    if (DeviceList.selected != -1) {
      // Unselect device
      String name = widget.devices[DeviceList.selected].name.replaceAll("✔️", "");;
      widget.devices[DeviceList.selected].name = name;
      DeviceList.selected = -1;
      // Deploy dialog
      await showDialog(
          context: context,
          builder: (context) {
            return build_dialog(
                context,
                "Error de conexión",
                "Se ha perdido la conexión al dispostivo $name.",
                "Ok"
            );
          }
      );
      setState(() {widget.devices.length;});
    }
  }


  @override
  void initState() {
    super.initState();
    if (widget.devices.isEmpty) {
      _getDevices();
    }
    widget.manager.addListener(this);
  }


  @override
  Widget build(BuildContext context) {
    const title = 'Lista Dispositivos';

    final items = widget.devices;

    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Colors.orange.shade50,
        body: Stack(
          children: [
            ListView.builder(
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
                      if (DeviceList.selected != -2) {
                        print("Connection attempt");
                        __connect(index);
                      }
                    }
                );
              },
            ),
            if (isConnecting)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
