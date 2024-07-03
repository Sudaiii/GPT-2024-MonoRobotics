import 'package:flutter/material.dart';
import 'package:robocarrera/ui/control.dart';
import 'package:robocarrera/ui/device_list.dart';

import 'package:robocarrera/bluetooth/manager.dart';


class MainScreen extends StatefulWidget {
  final BluetoothManager manager =  BluetoothManager();

  MainScreen({Key? key}) : super(key: key);


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoboRun' , style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
        ),),
        centerTitle: true,
        backgroundColor: Colors.brown,
        toolbarHeight: 20.0,
      ),
      body: Column(
        children: [
          ColoredBox(
            color: Colors.brown,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.gamepad, color: Colors.white), text: 'Control'),
                Tab(icon: Icon(Icons.settings, color: Colors.white), text: 'Configuración'),
              ],
              labelStyle: TextStyle(fontSize: 14.0),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.orange.shade900,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Control(manager: widget.manager),
                DeviceList(manager: widget.manager),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
