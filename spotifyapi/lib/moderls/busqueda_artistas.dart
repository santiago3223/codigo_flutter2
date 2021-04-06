// To parse this JSON data, do
//
//     final busquedaArtistas = busquedaArtistasFromJson(jsonString);

import 'dart:convert';

BusquedaArtistas busquedaArtistasFromJson(String str) => BusquedaArtistas.fromJson(json.decode(str));

String busquedaArtistasToJson(BusquedaArtistas data) => json.encode(data.toJson());

class BusquedaArtistas {
    BusquedaArtistas({
        this.artists,
    });

    Artists artists;

    factory BusquedaArtistas.fromJson(Map<String, dynamic> json) => BusquedaArtistas(
        artists: Artists.fromJson(json["artists"]),
    );

    Map<String, dynamic> toJson() => {
        "artists": artists.toJson(),
    };
}

class Artists {
    Artists({
        this.href,
        this.items,
        this.limit,
        this.next,
        this.offset,
        this.previous,
        this.total,
    });

    String href;
    List<Item> items;
    int limit;
    String next;
    int offset;
    dynamic previous;
    int total;

    factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
    };
}

class Item {
    Item({
        this.externalUrls,
        this.followers,
        this.genres,
        this.href,
        this.id,
        this.images,
        this.name,
        this.popularity,
        this.type,
        this.uri,
    });

    ExternalUrls externalUrls;
    Followers followers;
    List<String> genres;
    String href;
    String id;
    List<ArtistImage> images;
    String name;
    int popularity;
    Type type;
    String uri;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        followers: Followers.fromJson(json["followers"]),
        genres: List<String>.from(json["genres"].map((x) => x)),
        href: json["href"],
        id: json["id"],
        images: List<ArtistImage>.from(json["images"].map((x) => ArtistImage.fromJson(x))),
        name: json["name"],
        popularity: json["popularity"],
        type: typeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "external_urls": externalUrls.toJson(),
        "followers": followers.toJson(),
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "popularity": popularity,
        "type": typeValues.reverse[type],
        "uri": uri,
    };
}

class ExternalUrls {
    ExternalUrls({
        this.spotify,
    });

    String spotify;

    factory ExternalUrls.fromJson(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
    );

    Map<String, dynamic> toJson() => {
        "spotify": spotify,
    };
}

class Followers {
    Followers({
        this.href,
        this.total,
    });

    dynamic href;
    int total;

    factory Followers.fromJson(Map<String, dynamic> json) => Followers(
        href: json["href"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
    };
}

class ArtistImage {
    ArtistImage({
        this.height,
        this.url,
        this.width,
    });

    int height;
    String url;
    int width;

    factory ArtistImage.fromJson(Map<String, dynamic> json) => ArtistImage(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

enum Type { ARTIST }

final typeValues = EnumValues({
    "artist": Type.ARTIST
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
