
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();
    startScan();
  }

  void startScan() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));

    // Listen to scan results
    flutterBlue.scanResults.listen((results) {
      // Add the devices to the list
      for (int i = 0; i < results.length; i++) {
        ScanResult r = results[i];
        if (!devicesList.contains(r.device)) {
          setState(() {
            devicesList.add(r.device);
          });
        }
      }
    });

    // Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Conectar Bluetooth',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Icon(
            Icons.bluetooth,
            size: 100,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Encender Bluetooth',
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                value: false, // Cambia este valor según sea necesario
                onChanged: (bool value) {
                  value = true;
                  // Manejar el cambio de estado del switch
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Dispositivos disponibles',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ...devicesList.map((device) {
            return ListTile(
              title: Text(device.name),
              onTap: () async {
                try {
                  await device.connect();
                  // Después de conectar, puedes navegar a otra pantalla o realizar alguna acción
                } catch (e) {
                  // Maneja el error de conexión si ocurre
                  print(e);
                }
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}