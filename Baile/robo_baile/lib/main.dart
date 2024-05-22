// Copyright 2019-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io' show File, Platform;


import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:robobaile/ui/songs_list.dart';
import 'package:window_size/window_size.dart';

import 'ui/config.dart';

void main() {
  setupWindow();
  runApp(
    MaterialApp(
      home: HomePage(),
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

class HomePage extends StatelessWidget {
  HomePage({super.key});

  Widget? _child; // Variable para manejar el estado

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.music_note, color: Colors.green),
                  text: 'Música',
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: 'Configuración',
                ),
              ],
            ),
            title: const Text('Robobaile'),
          ),
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    SongList(),
                    Config(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}