import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/game.dart';
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
      appBar: AppBar(
        title: Text(widget.equipo.fullName),
      ),
      body: FutureBuilder(
        future: http.get(Uri.parse("https://www.balldontlie.io/api/v1/games")),
        builder: (c, s) {
          if (s.hasData) {
            List<Game> games = jsonDecode(s.data.body)["data"]
                .map<Game>((m) => Game.fromJson(m))
                .toList();

            return Container(
              child: ListView.builder(
                  itemCount: games.length,
                  itemBuilder: (c, i) => GameCard(game: games[i])),
            );
          }
          if (s.hasError) {
            return Center(
              child: Text(s.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    Key key,
    @required this.game,
  }) : super(key: key);

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 8, left: 32, right: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Text(
            game.homeTeam.name,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )),
          Text(
            game.homeTeamScore.toString(),
            style: TextStyle(fontSize: 36),
          ),
          Text(
            "-",
            style: TextStyle(fontSize: 36),
          ),
          Text(game.visitorTeamScore.toString(),
              style: TextStyle(fontSize: 36)),
          Expanded(
              child: Text(
            game.visitorTeam.name,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}
