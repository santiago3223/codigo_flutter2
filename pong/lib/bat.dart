import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double width;
  final double heigth;

  const Bat({Key key, this.width, this.heigth}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: heigth,
      color: Colors.blue,
    );
  }
}