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
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                widget.equipo.fullName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: http.get(Uri.parse(
                      "https://www.balldontlie.io/api/v1/games?seasons[]=2020&team_ids[]=${widget.equipo.id}")),
                  builder: (c, s) {
                    if (s.hasData) {
                      List<Game> games = jsonDecode(s.data.body)["data"]
                          .map<Game>((m) => Game.fromJson(m))
                          .toList();
                      int victorias = games
                          .where((element) =>
                              (element.visitorTeamScore >
                                      element.homeTeamScore &&
                                  widget.equipo.id == element.visitorTeam.id) ||
                              (element.visitorTeamScore <
                                      element.homeTeamScore &&
                                  widget.equipo.id == element.homeTeam.id))
                          .length;
                      games.sort((g1, g2) => g2.date.compareTo(g1.date));
                      return Container(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  itemCount: games.length,
                                  itemBuilder: (c, i) =>
                                      GameCard(game: games[i])),
                            ),
                            buildResultados(
                              victorias,
                              games.length - victorias,
                            )
                          ],
                        ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildResultados(int victorias, int derrotas) {
    return Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Victorias", style: TextStyle(fontSize: 20)),
                Text(
                  victorias.toString(),
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: [
                Text("Derrotas", style: TextStyle(fontSize: 20)),
                Text(
                  derrotas.toString(),
                  style: TextStyle(
                      fontSize: 36,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ));
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
