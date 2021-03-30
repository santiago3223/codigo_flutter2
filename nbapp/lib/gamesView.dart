import 'package:flutter/material.dart';

import 'models/team.dart';

class GamesView extends StatefulWidget {
  final Team equipo;

  GamesView(this.equipo);
  @override
  _GamesViewState createState() => _GamesViewState();
}

class _GamesViewState extends State<GamesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.equipo.fullName),),
    );
  }
}