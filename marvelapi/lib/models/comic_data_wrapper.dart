// To parse this JSON data, do
//
//     final comicDataWrapper = comicDataWrapperFromJson(jsonString);

import 'dart:convert';

ComicDataWrapper comicDataWrapperFromJson(String str) => ComicDataWrapper.fromJson(json.decode(str));

String comicDataWrapperToJson(ComicDataWrapper data) => json.encode(data.toJson());

class ComicDataWrapper {
    ComicDataWrapper({
        this.code,
        this.status,
        this.copyright,
        this.attributionText,
        this.attributionHtml,
        this.etag,
        this.data,
    });

    int code;
    String status;
    String copyright;
    String attributionText;
    String attributionHtml;
    String etag;
    ComicDataContainer data;

    factory ComicDataWrapper.fromJson(Map<String, dynamic> json) => ComicDataWrapper(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: ComicDataContainer.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
    };
}

class ComicDataContainer {
    ComicDataContainer({
        this.offset,
        this.limit,
        this.total,
        this.count,
        this.results,
    });

    int offset;
    int limit;
    int total;
    int count;
    List<Comic> results;

    factory ComicDataContainer.fromJson(Map<String, dynamic> json) => ComicDataContainer(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results: List<Comic>.from(json["results"].map((x) => Comic.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Comic {
    Comic({
        this.id,
        this.digitalId,
        this.title,
        this.issueNumber,
        this.variantDescription,
        this.description,
        this.modified,
        this.isbn,
        this.upc,
        this.diamondCode,
        this.ean,
        this.issn,
        this.format,
        this.pageCount,
        this.textObjects,
        this.resourceUri,
        this.urls,
        this.series,
        this.variants,
        this.collections,
        this.collectedIssues,
        this.dates,
        this.prices,
        this.thumbnail,
        this.images,
        this.creators,
        this.characters,
        this.stories,
        this.events,
    });

    int id;
    int digitalId;
    String title;
    int issueNumber;
    String variantDescription;
    String description;
    String modified;
    String isbn;
    String upc;
    String diamondCode;
    String ean;
    String issn;
    String format;
    int pageCount;
    List<TextObject> textObjects;
    String resourceUri;
    List<Url> urls;
    Series series;
    List<Series> variants;
    List<dynamic> collections;
    List<dynamic> collectedIssues;
    List<Date> dates;
    List<Price> prices;
    Thumbnail thumbnail;
    List<Thumbnail> images;
    Creators creators;
    Characters characters;
    Stories stories;
    Characters events;

    factory Comic.fromJson(Map<String, dynamic> json) => Comic(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: json["format"],
        pageCount: json["pageCount"],
        textObjects: List<TextObject>.from(json["textObjects"].map((x) => TextObject.fromJson(x))),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        series: Series.fromJson(json["series"]),
        variants: List<Series>.from(json["variants"].map((x) => Series.fromJson(x))),
        collections: List<dynamic>.from(json["collections"].map((x) => x)),
        collectedIssues: List<dynamic>.from(json["collectedIssues"].map((x) => x)),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        images: List<Thumbnail>.from(json["images"].map((x) => Thumbnail.fromJson(x))),
        creators: Creators.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        stories: Stories.fromJson(json["stories"]),
        events: Characters.fromJson(json["events"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": format,
        "pageCount": pageCount,
        "textObjects": List<dynamic>.from(textObjects.map((x) => x.toJson())),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "series": series.toJson(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "collections": List<dynamic>.from(collections.map((x) => x)),
        "collectedIssues": List<dynamic>.from(collectedIssues.map((x) => x)),
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "events": events.toJson(),
    };
}

class Characters {
    Characters({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    int available;
    String collectionUri;
    List<Series> items;
    int returned;

    factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Series>.from(json["items"].map((x) => Series.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class Series {
    Series({
        this.resourceUri,
        this.name,
    });

    String resourceUri;
    String name;

    factory Series.fromJson(Map<String, dynamic> json) => Series(
        resourceUri: json["resourceURI"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
    };
}

class Creators {
    Creators({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    int available;
    String collectionUri;
    List<CreatorsItem> items;
    int returned;

    factory Creators.fromJson(Map<String, dynamic> json) => Creators(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<CreatorsItem>.from(json["items"].map((x) => CreatorsItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class CreatorsItem {
    CreatorsItem({
        this.resourceUri,
        this.name,
        this.role,
    });

    String resourceUri;
    String name;
    String role;

    factory CreatorsItem.fromJson(Map<String, dynamic> json) => CreatorsItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": role,
    };
}

class Date {
    Date({
        this.type,
        this.date,
    });

    String type;
    String date;

    factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: json["type"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
    };
}

class Thumbnail {
    Thumbnail({
        this.path,
        this.extension,
    });

    String path;
    String extension;

    factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
    );

    Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
    };
}

class Price {
    Price({
        this.type,
        this.price,
    });

    String type;
    double price;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        type: json["type"],
        price: json["price"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
    };
}

class Stories {
    Stories({
        this.available,
        this.collectionUri,
        this.items,
        this.returned,
    });

    int available;
    String collectionUri;
    List<StoriesItem> items;
    int returned;

    factory Stories.fromJson(Map<String, dynamic> json) => Stories(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
        returned: json["returned"],
    );

    Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
    };
}

class StoriesItem {
    StoriesItem({
        this.resourceUri,
        this.name,
        this.type,
    });

    String resourceUri;
    String name;
    String type;

    factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
        resourceUri: json["resourceURI"],
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "type": type,
    };
}

class TextObject {
    TextObject({
        this.type,
        this.language,
        this.text,
    });

    String type;
    String language;
    String text;

    factory TextObject.fromJson(Map<String, dynamic> json) => TextObject(
        type: json["type"],
        language: json["language"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "language": language,
        "text": text,
    };
}

class Url {
    Url({
        this.type,
        this.url,
    });

    String type;
    String url;

    factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
    };
}
