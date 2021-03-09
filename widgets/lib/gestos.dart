import 'package:flutter/material.dart';

class Gestos extends StatefulWidget {
  @override
  _GestosState createState() => _GestosState();
}

class _GestosState extends State<Gestos> {
  double margen = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(left: margen),
          height: 200,
          width: 200,
          color: Colors.blue,
          child: Text("hola"),
        ),
        onTap: (){print("Tapeo");},
        onDoubleTap: (){print("Double Tap");},
        onLongPress: (){print("Long Press");},
        onHorizontalDragStart: (d){
          print(d);
        } ,
        onHorizontalDragUpdate: (d){
          setState(() {
            margen = 0 + d.localPosition.dx;  
          });
          print(d);
        } ,
        onHorizontalDragEnd: (d){
          print(d);
        },
        onScaleStart: (d){
          print(d);
        },
      ),
    );
  }
}
