import 'package:flutter/cupertino.dart';



class Device {
  String name;
  String address;

  Device({
    required this.name,
    required this.address
  });


  Widget buildTitle(BuildContext context) => Text(name);
  Widget buildSubtitle(BuildContext context) => Text(address);


}