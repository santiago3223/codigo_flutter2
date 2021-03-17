import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
    );
  }
}