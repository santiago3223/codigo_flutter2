import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
 List<Slide> slides = [];

 @override
 void initState() {
   super.initState();

   slides.add(
     new Slide(
       title: "ERASER",
       description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
       pathImage: "images/photo_eraser.png",
       backgroundColor: Color(0xfff5a623),
     ),
   );
   slides.add(
     new Slide(
       title: "PENCIL",
       description: "Ye indulgence unreserved connection alteration appearance",
       pathImage: "images/photo_pencil.png",
       backgroundColor: Color(0xff203152),
     ),
   );
   slides.add(
     new Slide(
       title: "RULER",
       description:
       "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
       pathImage: "images/photo_ruler.png",
       backgroundColor: Color(0xff9932CC),
     ),
   );
 }

 void onDonePress() {
   // Do what you want
 }

 @override
 Widget build(BuildContext context) {
   return IntroSlider(
     slides: this.slides,
     onDonePress: this.onDonePress,
   );
 }
}