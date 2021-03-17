import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pong/ball.dart';

import 'bat.dart';

enum Direction { up, down, left, right }

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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double width;
  double heigth;
  double posX = 0;
  double posY = 0;
  double batWidth = 100;
  double batHeigth = 20;
  double batPosition = 0;
  Animation<double> animation;
  AnimationController controller;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  int velocidad = 1;
  int score = 0;
  double aleatorioV = 1;
  double aleatorioH = 1;

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      aleatorioV=numeroAleatoreo();
    }
    if (posX >= width - 50 && hDir == Direction.right) {
      hDir = Direction.left;
      aleatorioV=numeroAleatoreo();
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      aleatorioH=numeroAleatoreo();
    }
    if (posY >= heigth - 125 && vDir == Direction.down) {
      vDir = Direction.up;
      aleatorioH=numeroAleatoreo();
    }

    if (posY >= heigth - 145) {
      if (posX >= batPosition - 50 && posX <= (batPosition + batWidth + 50)) {
        vDir = Direction.up;
        velocidad++;
        score++;
      } else {
        controller.stop();
        mostrarAlert(context);
      }
    }
  }

  void mostrarAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Perdiste"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        score=0;
                        velocidad =1;
                        posX=0;
                        posY=0;
                      });
                      controller.repeat();
                      Navigator.pop(context);
                    },
                    child: Text("reiniciar"))
              ],
            ));
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller =
        AnimationController(duration: Duration(minutes: 1000), vsync: this);
    animation = Tween<double>(begin: 0, end: 1000).animate(controller);
    animation.addListener(() {
      setState(() {
        posX = hDir == Direction.right ? posX + velocidad*aleatorioH : posX - velocidad*aleatorioH;
        posY = vDir == Direction.down ? posY + velocidad*aleatorioV : posY - velocidad*aleatorioV;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  double numeroAleatoreo(){
    Random r = Random();
    int aleatorio = r.nextInt(101); // 0 - 100 
    return (50 + aleatorio)/100; // 0.5 - 1.5 
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    heigth = MediaQuery.of(context).size.height;
    batWidth = width / 5;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          child: Stack(
            children: [
              Positioned(
                  right: 15,
                  child: Text(
                    "$score",
                    style: TextStyle(fontSize: 25),
                  )),
              Positioned(
                child: Ball(),
                top: posY,
                left: posX,
              ),
              Positioned(
                bottom: 0,
                left: batPosition,
                child: GestureDetector(
                    onHorizontalDragUpdate: (DragUpdateDetails update) {
                      double nuevaPosicionBat= batPosition +update.delta.dx;
                      if (nuevaPosicionBat>0 && nuevaPosicionBat< width - batWidth)
                      setState(() {
                        batPosition += update.delta.dx;
                      });
                    },
                    child: Bat(
                      width: batWidth,
                      heigth: 20,
                    )),
              ),
            ],
          ),
        ));
  }
}
