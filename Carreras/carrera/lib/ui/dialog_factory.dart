import 'package:flutter/material.dart';



AlertDialog build_dialog(
    BuildContext context,
    String title,
    String content,
    String button_message,
    ) {
  return AlertDialog(
      title: Text(title),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20
      ),
      actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text(button_message)
        ),
      ],
      content: Text(content),
  );
}