
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:robobaile/bluetooth/manager.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceList extends StatefulWidget {
  final BluetoothManager manager;

  DeviceList({Key? key, required this.manager}) : super(key: key);

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  List<BluetoothDevice> _devices = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchDevices();
  }

  Future<void> _fetchDevices() async {
    setState(() {
      _isLoading = true;
    });

    // Solicitar permisos necesarios
    await [
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();

    if (await Permission.bluetoothConnect.isGranted) {
      // Obtener dispositivos emparejados
      List<BluetoothDevice> devices = await widget.manager.listDevices();
      setState(() {
        _devices = devices;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // cuando los permisos no son otorgados
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Permiso denegado"),
          content: Text("Los permisos de Bluetooth son necesarios para listar dispositivos."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Aceptar"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Dispositivos"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _devices.isEmpty
          ? Center(child: Text("No se encontraron dispositivos"))
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            title: Text(device.name ?? "Dispositivo Desconocido"),
            subtitle: Text(device.address),
            onTap: () {
              widget.manager.connect(device.address);
            },
          );
        },
      ),
    );
  }
}
