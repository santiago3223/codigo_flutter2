import 'package:flutter/material.dart';
import 'package:pong/ball.dart';

import 'bat.dart';

enum Direction{up, down, left, right}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pong'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  double width;
  double heigth;
  double posX =0;
  double posY =0;
  double batWidth = 100;
  double batHeigth = 20;
  double batPosition = 0;
  Animation<double> animation;
  AnimationController controller;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  void checkBorders(){
    if(posX <= 0 && hDir==Direction.left){
      hDir = Direction.right;
    }
    if(posX >= width && hDir==Direction.right){
      hDir = Direction.left;
    }
    if(posY <= 0 && vDir==Direction.up){
      vDir = Direction.down;
    }
    if(posY >= heigth && vDir==Direction.down){
      vDir = Direction.up;
    }
  }

  @override
  void initState() {
   
    posX = 0;
    posY = 0;
    controller = AnimationController(duration: Duration(minutes: 10000), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() { 
      setState(() {
        posX= hDir==Direction.right? posX+1:posX-1;
        posY= vDir==Direction.down? posY+1:posY-1;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    heigth = MediaQuery.of(context).size.height;
    batWidth = width/5;
    

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Stack(children: [
          Positioned(child: Ball(),top :posY, left: posX,),
          Positioned(child: Bat(width: batWidth, heigth: 20,),bottom :0),
        ],),
      )
    );
  }
}
