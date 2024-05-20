// myApp.dart
import 'dart:ui';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pinkAccent, Colors.blueAccent],
          ),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 500,
            color: Colors.white.withOpacity(0.5),
            child: MusicPlayer(),
          ),
        ),
      ),
    );
  }
}

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Image.network(
            'URL de la foto de la canción',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Título de la canción',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          'Nombre del artista',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              // Lógica para reproducir o pausar la canción
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.skip_previous),
              onPressed: () {
                // Lógica para reproducir la canción anterior
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                // Lógica para reproducir la siguiente canción
              },
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('00:00'), // Temporizador
            Slider(
              value: 0.5, // Valor de ejemplo
              onChanged: (newValue) {
                // Lógica para cambiar el tiempo de reproducción
              },
            ),
            Text('03:45'), // Duración de la canción
          ],
        ),
      ],
    );
  }
}
