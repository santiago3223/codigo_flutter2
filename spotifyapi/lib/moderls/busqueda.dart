import 'dart:convert';

import 'package:spotifyapi/moderls/albums.dart';
import 'package:spotifyapi/moderls/playlists.dart';
import 'package:spotifyapi/moderls/tracks.dart' as track;

import 'artists.dart';

Busqueda busquedaFromJson(String str) => Busqueda.fromJson(json.decode(str));

String busquedaToJson(Busqueda data) => json.encode(data.toJson());

class Busqueda {
    Busqueda({
        this.artists,
        this.playlists,
        this.albums,
        this.tracks
    });

    Artists artists;
    Playlists playlists;
    Albums albums;
    track.Tracks tracks;

    factory Busqueda.fromJson(Map<String, dynamic> json) => Busqueda(
        artists: json["artists"]==null?null:Artists.fromJson(json["artists"]),
        playlists: json["playlists"]==null?null: Playlists.fromJson(json["playlists"]),
        albums: json["albums"]==null?null: Albums.fromJson(json["albums"]),
        tracks: json["tracks"]==null?null: track.Tracks.fromJson(json["tracks"])
    );

    Map<String, dynamic> toJson() => {
        "artists": artists==null?null: artists.toJson(),
        "playlists": playlists==null?null: playlists.toJson(),
        "albums": albums==null?null: albums.toJson(),
        "tracks": tracks==null?null: tracks.toJson(),
    };
}

