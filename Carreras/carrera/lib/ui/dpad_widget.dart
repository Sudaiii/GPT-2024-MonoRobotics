import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DPad extends StatefulWidget {
  final void Function(int dx, int dy) onDirectionChanged;

  DPad({required this.onDirectionChanged});

  @override
  _DPadState createState() => _DPadState();
}

class _DPadState extends State<DPad> {
  int _pressedButton = -1;

  void _handleDirectionChange(int buttonIndex, int dx, int dy) {
    setState(() {
      _pressedButton = buttonIndex;
    });
    widget.onDirectionChanged(dx, dy);
    HapticFeedback.vibrate();
  }

  void _handleDirectionEnd() {
    setState(() {
      _pressedButton = -1;
    });
    widget.onDirectionChanged(0, 0);
  }

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
                _buildDirectionButton(0, Icons.arrow_drop_up, 0, 1),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirectionButton(1, Icons.arrow_left, -1, 0),
                SizedBox(width: 40), // Space for the empty center
                _buildDirectionButton(2, Icons.arrow_right, 1, 0),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDirectionButton(3, Icons.arrow_drop_down, 0, -1),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDirectionButton(int index, IconData icon, int dx, int dy) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _pressedButton == index ? Colors.orange : Colors.orange.shade100, // Change color on press
        border: Border.all(color: Colors.black87), // Border color and width
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Material(
        color: Colors.transparent, // Makes the background transparent
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0), // Match the rounded corners
          onTapDown: (_) {
            _handleDirectionChange(index, dx, dy);
          },
          onTapUp: (_) {
            _handleDirectionEnd();
          },
          onTapCancel: () {
            _handleDirectionEnd();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
