

import 'package:flutter/material.dart';

class TimerButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const TimerButton({Key key, this.color, this.text, this.size, this.onPressed}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(text, style: TextStyle(color: Colors.white),),
      onPressed: onPressed,
      color: color,
      minWidth: size,
    );
  }
}