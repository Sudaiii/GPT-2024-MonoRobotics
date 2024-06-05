import 'package:flutter/material.dart';

class DPad extends StatelessWidget {
  final void Function(int dx, int dy) onDirectionChanged;

  DPad({required this.onDirectionChanged});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft, // Ajusta la posición hacia la izquierda
      child: Padding(
        padding: const EdgeInsets.only(left: 120.0), // Ajusta este valor según sea necesario
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirectionButton(Icons.arrow_drop_up, 0, 1),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirectionButton(Icons.arrow_left, -1, 0),
                SizedBox(width: 40), // Space for the empty center
                _buildDirectionButton(Icons.arrow_right, 1, 0),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirectionButton(Icons.arrow_drop_down, 0, -1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionButton(IconData icon, int dx, int dy) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black26, // Background color
        border: Border.all(color: Colors.black87), // Border color and width
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: GestureDetector(
        onTapDown: (_) {
          onDirectionChanged(dx, dy);
        },
        onTapUp: (_) {
          onDirectionChanged(0, 0);
        },
        onTapCancel: () {
          onDirectionChanged(0, 0);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
      ),
    );
  }
}
