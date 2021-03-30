// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

import 'package:nbapp/models/team.dart';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
    Game({
        this.id,
        this.date,
        this.homeTeam,
        this.homeTeamScore,
        this.period,
        this.postseason,
        this.season,
        this.status,
        this.time,
        this.visitorTeam,
        this.visitorTeamScore,
    });

    int id;
    DateTime date;
    Team homeTeam;
    int homeTeamScore;
    int period;
    bool postseason;
    int season;
    String status;
    String time;
    Team visitorTeam;
    int visitorTeamScore;

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        homeTeam: Team.fromJson(json["home_team"]),
        homeTeamScore: json["home_team_score"],
        period: json["period"],
        postseason: json["postseason"],
        season: json["season"],
        status: json["status"],
        time: json["time"],
        visitorTeam: Team.fromJson(json["visitor_team"]),
        visitorTeamScore: json["visitor_team_score"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "home_team": homeTeam.toJson(),
        "home_team_score": homeTeamScore,
        "period": period,
        "postseason": postseason,
        "season": season,
        "status": status,
        "time": time,
        "visitor_team": visitorTeam.toJson(),
        "visitor_team_score": visitorTeamScore,
    };
}