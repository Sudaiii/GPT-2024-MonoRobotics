// main.dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:robobaile/ui/songs_list.dart';
import 'package:robobaile/ui/device_list.dart';
import 'package:robobaile/ui/music_player_state.dart';
import 'package:robobaile/bluetooth/manager.dart';
import 'package:robobaile/ui/music_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupWindow();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MusicPlayerState(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 1024;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Robobaile');
    setWindowMinSize(const Size(windowWidth, windowHeight));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home:  HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final BluetoothManager manager = BluetoothManager();
  HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isFullScreenPlayerVisible = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    final musicPlayerState = Provider.of<MusicPlayerState>(context, listen: false);
    musicPlayerState.addListener(() {
      setState(() {
        isFullScreenPlayerVisible = musicPlayerState.isFullScreenPlayerVisible;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final musicPlayerState = Provider.of<MusicPlayerState>(context);
    return Scaffold(
      appBar: isFullScreenPlayerVisible
          ? null
          : AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.music_note, color: Colors.green), text: 'Música'),
            Tab(icon: Icon(Icons.settings), text: 'Configuración'),
          ],
        ),
        title: const Text('Robobaile'),
      ),
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              const SongList(),
              DeviceList(manager: widget.manager),
            ],
          ),
          if (musicPlayerState.isPlaying && !musicPlayerState.isFullScreenPlayerVisible)
            const Align(
              alignment: Alignment.bottomCenter,
              child: MiniPlayer(),
            ),
        ],
      ),
    );
  }
}
