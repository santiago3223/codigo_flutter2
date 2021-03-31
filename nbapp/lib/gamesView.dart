import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://i.pinimg.com/originals/e9/5f/56/e95f56d52fea3ab71221fdc5d10efbd0.jpg"),
                    fit: BoxFit.cover)),
          ),
          FutureBuilder(
            future:
                http.get(Uri.parse("https://www.balldontlie.io/api/v1/games?seasons[]=2020&team_ids[]=${widget.equipo.id}")),
            builder: (c, s) {
              if (s.hasData) {
                List<Game> games = jsonDecode(s.data.body)["data"]
                    .map<Game>((m) => Game.fromJson(m))
                    .toList();
                games.sort((g1, g2) => g2.date.compareTo(g1.date));
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
        ],
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  GameCard({
    Key key,
    @required this.game,
  }) : super(key: key);

  final Game game;
  final String urlLogo =
      "https://www.nba.com/.element/img/1.0/teamsites/logos/teamlogos_500x500/";
  final DateFormat format = DateFormat("dd/MM/y");

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.8),
      margin: EdgeInsets.only(top: 8, left: 24, right: 24),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(format.format(game.date)),
            Row(
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
                  style: TextStyle(
                      fontSize: 36,
                      color: game.homeTeamScore > game.visitorTeamScore
                          ? Colors.blue
                          : Colors.black54,
                      fontWeight: game.homeTeamScore > game.visitorTeamScore
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                Text(
                  " - ",
                  style: TextStyle(fontSize: 36),
                ),
                Text(game.visitorTeamScore.toString(),
                    style: TextStyle(
                        fontSize: 36,
                        color: game.homeTeamScore < game.visitorTeamScore
                          ? Colors.blue
                          : Colors.black54,
                        fontWeight: game.homeTeamScore < game.visitorTeamScore
                            ? FontWeight.bold
                            : FontWeight.normal)),
                Expanded(
                    child: Text(
                  game.visitorTeam.name,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network(
                  urlLogo + game.homeTeam.abbreviation.toLowerCase() + ".png",
                  height: 75,
                ),
                Image.network(
                  urlLogo +
                      game.visitorTeam.abbreviation.toLowerCase() +
                      ".png",
                  height: 75,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
