import 'package:flutter/material.dart';
import 'package:widgets/widgets_basicos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WidgetsBasicosPage(),
    );
  }
}
