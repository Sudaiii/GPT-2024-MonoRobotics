import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';



class Device {
  String name;
  String address;

  Device({
    required this.name,
    required this.address
  });


  Widget buildTitle(BuildContext context) => Text(address);
  Widget buildSubtitle(BuildContext context) => Text(name);


}