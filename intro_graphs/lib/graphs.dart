import 'package:flutter/material.dart';

import 'line_chart_sample_9.dart';

class Graficos extends StatefulWidget {
  @override
  _GraficosState createState() => _GraficosState();
}

class _GraficosState extends State<Graficos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Graficos"),),
      body: Container(
        margin: EdgeInsets.all(25),
        height: 200,
        child: LineChartSample9()),
    );
  }
}