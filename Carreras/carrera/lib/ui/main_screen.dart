import 'package:flutter/material.dart';
import 'package:robocarrera/ui/control.dart';
import 'package:robocarrera/ui/device_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

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
        title: const Text('RoboRun'),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 20.0,
      ),
      body: Column(
        children: [
          ColoredBox(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.gamepad, color: Colors.black), text: 'Control'),
                Tab(icon: Icon(Icons.settings, color: Colors.black), text: 'Configuración'),
              ],
              labelStyle: TextStyle(fontSize: 14.0),
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.purple,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Control(),
                DeviceList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
