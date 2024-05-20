import 'package:flutter/material.dart';

class Abc extends StatefulWidget {
  @override
  _Abc createState() => _Abc();
}

class _Abc extends State<Abc> {
  bool isPlaying = false;
  double progress = 0.0;
  Duration duration = Duration(seconds: 0);

  // Datos de ejemplo para el título y el artista de la canción
  String songTitle = "Nombre de la canción";
  String artist = "Artista";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0, // Aumentamos la altura del widget
      decoration: BoxDecoration(
        color: Colors.pink, // Cambiamos el color a rosado
        borderRadius: BorderRadius.circular(20.0), // Bordes circulares
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    songTitle,
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black), // Título en negro
                  ),
                  Text(
                    artist,
                    style: TextStyle(fontSize: 14.0, color: Colors.yellow[700]), // Artista en celeste
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Color blanco para el fondo del círculo
                border: Border.all(color: Colors.pink, width: 2.0), // Borde rosado
              ),
              child: IconButton(
                icon: isPlaying ? Icon(Icons.pause, color: Colors.pink) : Icon(Icons.play_arrow, color: Colors.pink), // Icono con color rosado
                onPressed: () {
                  // Handle play/pause button press
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}