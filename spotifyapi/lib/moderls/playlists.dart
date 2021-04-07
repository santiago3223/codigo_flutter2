class Playlists {
    Playlists({
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

    factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
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
        this.collaborative,
        this.description,
        this.externalUrls,
        this.href,
        this.id,
        this.images,
        this.name,
        this.owner,
        this.primaryColor,
        this.public,
        this.snapshotId,
        this.tracks,
        this.type,
        this.uri,
    });

    bool collaborative;
    String description;
    ExternalUrls externalUrls;
    String href;
    String id;
    List<PlaylistImage> images;
    String name;
    Owner owner;
    dynamic primaryColor;
    dynamic public;
    String snapshotId;
    Tracks tracks;
    ItemType type;
    String uri;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        collaborative: json["collaborative"],
        description: json["description"],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<PlaylistImage>.from(json["images"].map((x) => PlaylistImage.fromJson(x))),
        name: json["name"],
        owner: Owner.fromJson(json["owner"]),
        primaryColor: json["primary_color"],
        public: json["public"],
        snapshotId: json["snapshot_id"],
        tracks: Tracks.fromJson(json["tracks"]),
        type: itemTypeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "collaborative": collaborative,
        "description": description,
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "name": name,
        "owner": owner.toJson(),
        "primary_color": primaryColor,
        "public": public,
        "snapshot_id": snapshotId,
        "tracks": tracks.toJson(),
        "type": itemTypeValues.reverse[type],
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

class PlaylistImage {
    PlaylistImage({
        this.height,
        this.url,
        this.width,
    });

    int height;
    String url;
    int width;

    factory PlaylistImage.fromJson(Map<String, dynamic> json) => PlaylistImage(
        height: json["height"] == null ? null : json["height"],
        url: json["url"],
        width: json["width"] == null ? null : json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "url": url,
        "width": width == null ? null : width,
    };
}

class Owner {
    Owner({
        this.displayName,
        this.externalUrls,
        this.href,
        this.id,
        this.type,
        this.uri,
    });

    String displayName;
    ExternalUrls externalUrls;
    String href;
    String id;
    OwnerType type;
    String uri;

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        displayName: json["display_name"],
        externalUrls: ExternalUrls.fromJson(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        type: ownerTypeValues.map[json["type"]],
        uri: json["uri"],
    );

    Map<String, dynamic> toJson() => {
        "display_name": displayName,
        "external_urls": externalUrls.toJson(),
        "href": href,
        "id": id,
        "type": ownerTypeValues.reverse[type],
        "uri": uri,
    };
}

enum OwnerType { USER }

final ownerTypeValues = EnumValues({
    "user": OwnerType.USER
});

class Tracks {
    Tracks({
        this.href,
        this.total,
    });

    String href;
    int total;

    factory Tracks.fromJson(Map<String, dynamic> json) => Tracks(
        href: json["href"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "href": href,
        "total": total,
    };
}

enum ItemType { PLAYLIST }

final itemTypeValues = EnumValues({
    "playlist": ItemType.PLAYLIST
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
