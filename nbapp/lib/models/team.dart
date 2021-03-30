// To parse this JSON data, do
//
//     final team = teamFromJson(jsonString);

import 'dart:convert';

Team teamFromJson(String str) => Team.fromJson(json.decode(str));

String teamToJson(Team data) => json.encode(data.toJson());

class Team {
    Team({
        this.id,
        this.abbreviation,
        this.city,
        this.conference,
        this.division,
        this.fullName,
        this.name,
    });

    int id;
    String abbreviation;
    String city;
    String conference;
    String division;
    String fullName;
    String name;

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        abbreviation: json["abbreviation"],
        city: json["city"],
        conference: json["conference"],
        division: json["division"],
        fullName: json["full_name"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "abbreviation": abbreviation,
        "city": city,
        "conference": conference,
        "division": division,
        "full_name": fullName,
        "name": name,
    };
}
