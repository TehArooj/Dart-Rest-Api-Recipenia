// To parse   thisJSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

RecipeModel recipeModelFromJson(String str) =>
    RecipeModel.fromJson(json.decode(str));

String? recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  RecipeModel({
    this.from,
    this.to,
    this.count,
    this.links,
    this.hits,
  });

  int? from;
  int? to;
  int? count;
  RecipeModelLinks? links;
  List<Hit>? hits;

  factory RecipeModel.fromJson(Map<String?, dynamic> json) => RecipeModel(
        from: json["from"],
        to: json["to"],
        count: json["count"],
        links: RecipeModelLinks.fromJson(json["_links"]),
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "from": from,
        "to": to,
        "count": count,
        "_links": links!.toJson(),
        "hits": List<dynamic>.from(hits!.map((x) => x.toJson())),
      };
}

class Hit {
  Hit({
    this.recipe,
  });

  Recipe? recipe;

  factory Hit.fromJson(Map<String?, dynamic> json) => Hit(
        recipe: Recipe.fromJson(json["recipe"]),
      );

  Map<String?, dynamic> toJson() => {
        "recipe": recipe!.toJson(),
      };
}

class HitLinks {
  HitLinks({
    this.self,
  });

  Self? self;

  factory HitLinks.fromJson(Map<String?, dynamic> json) => HitLinks(
        self: Self.fromJson(json["self"]),
      );

  Map<String?, dynamic> toJson() => {
        "self": self!.toJson(),
      };
}

class Self {
  Self({
    this.href,
    this.title,
  });

  String? href;
  String? title;

  factory Self.fromJson(Map<String?, dynamic> json) => Self(
        href: json["href"],
        title: json["title"],
      );

  Map<String?, dynamic> toJson() => {
        "href": href,
        "title": title,
      };
}

class Recipe {
  Recipe({
    this.uri,
    this.label,
    this.image,
    this.images,
    this.source,
    this.url,
    this.shareAs,
    this.recipeYield,
    this.dietLabels,
    this.healthLabels,
    this.cautions,
    this.ingredientLines,
    this.ingredients,
    this.calories,
    this.totalWeight,
    this.totalTime,
  });

  String? uri;
  String? label;
  String? image;
  Images? images;
  String? source;
  String? url;
  String? shareAs;
  double? recipeYield;
  List<String?>? dietLabels;
  List<String?>? healthLabels;
  List<String?>? cautions;
  List<String?>? ingredientLines;
  List<Ingredient>? ingredients;
  double? calories;
  double? totalWeight;
  double? totalTime;

  factory Recipe.fromJson(Map<String?, dynamic> json) => Recipe(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        images: Images.fromJson(json["images"]),
        source: json["source"],
        url: json["url"],
        shareAs: json["shareAs"],
        recipeYield: json["yield"],
        dietLabels: List<String?>.from(json["dietLabels"].map((x) => x)),
        healthLabels: List<String?>.from(json["healthLabels"].map((x) => x)),
        cautions: List<String?>.from(json["cautions"].map((x) => x)),
        ingredientLines:
            List<String?>.from(json["ingredientLines"].map((x) => x)),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        calories: json["calories"].toDouble(),
        totalWeight: json["totalWeight"].toDouble(),
        totalTime: json["totalTime"],
      );

  Map<String?, dynamic> toJson() => {
        "uri": uri,
        "label": label,
        "image": image,
        "images": images!.toJson(),
        "source": source,
        "url": url,
        "shareAs": shareAs,
        "yield": recipeYield,
        "dietLabels": List<dynamic>.from(dietLabels!.map((x) => x)),
        "healthLabels": List<dynamic>.from(healthLabels!.map((x) => x)),
        "cautions": List<dynamic>.from(cautions!.map((x) => x)),
        "ingredientLines": List<dynamic>.from(ingredientLines!.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "calories": calories,
        "totalWeight": totalWeight,
        "totalTime": totalTime,
      };
}

class Digest {
  Digest({
    this.label,
    this.tag,
    this.schemaOrgTag,
    this.total,
    this.hasRdi,
    this.daily,
    this.unit,
    this.sub,
  });

  String? label;
  String? tag;
  String? schemaOrgTag;
  double? total;
  bool? hasRdi;
  double? daily;
  Unit? unit;
  List<Digest>? sub;

  factory Digest.fromJson(Map<String, dynamic> json) => Digest(
        label: json["label"],
        tag: json["tag"],
        schemaOrgTag:
            json["schemaOrgTag"] == null ? null : json["schemaOrgTag"],
        total: json["total"].toDouble(),
        hasRdi: json["hasRDI"],
        daily: json["daily"].toDouble(),
        unit: unitValues.map[json["unit"]],
        sub: json["sub"] == null
            ? null
            : List<Digest>.from(json["sub"].map((x) => Digest.fromJson(x))),
      );

  Map<String?, dynamic> toJson() => {
        "label": label,
        "tag": tag,
        "schemaOrgTag": schemaOrgTag == null ? null : schemaOrgTag,
        "total": total,
        "hasRDI": hasRdi,
        "daily": daily,
        "unit": unitValues.reverse![unit],
        "sub": sub == null
            ? null
            : List<dynamic>.from(sub!.map((x) => x.toJson())),
      };
}

enum Unit { G, MG, UNIT_G, EMPTY, KCAL }

final unitValues = EnumValues({
  "%": Unit.EMPTY,
  "g": Unit.G,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class Images {
  Images({
    this.thumbnail,
    this.small,
    this.regular,
  });

  Regular? thumbnail;
  Regular? small;
  Regular? regular;

  factory Images.fromJson(Map<String?, dynamic> json) => Images(
        thumbnail: Regular.fromJson(json["THUMBNAIL"]),
        small: Regular.fromJson(json["SMALL"]),
        regular: Regular.fromJson(json["REGULAR"]),
      );

  Map<String?, dynamic> toJson() => {
        "THUMBNAIL": thumbnail!.toJson(),
        "SMALL": small!.toJson(),
        "REGULAR": regular!.toJson(),
      };
}

class Regular {
  Regular({
    this.url,
    this.width,
    this.height,
  });

  String? url;
  int? width;
  int? height;

  factory Regular.fromJson(Map<String?, dynamic> json) => Regular(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String?, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class Ingredient {
  Ingredient({
    this.text,
    this.quantity,
    this.food,
    this.weight,
    this.image,
  });

  String? text;
  double? quantity;
  String? food;
  double? weight;
  String? image;

  factory Ingredient.fromJson(Map<String?, dynamic> json) => Ingredient(
        text: json["text"],
        quantity: json["quantity"].toDouble(),
        food: json["food"],
        weight: json["weight"].toDouble(),
        image: json["image"],
      );

  Map<String?, dynamic> toJson() => {
        "text": text,
        "quantity": quantity,
        "food": food,
        "weight": weight,
        "image": image,
      };
}

class Total {
  Total({
    this.label,
    this.quantity,
    this.unit,
  });

  String? label;
  double? quantity;
  Unit? unit;

  factory Total.fromJson(Map<String?, dynamic> json) => Total(
        label: json["label"],
        quantity: json["quantity"].toDouble(),
        unit: unitValues.map[json["unit"]],
      );

  Map<String?, dynamic> toJson() => {
        "label": label,
        "quantity": quantity,
        "unit": unitValues.reverse![unit],
      };
}

class RecipeModelLinks {
  RecipeModelLinks();

  factory RecipeModelLinks.fromJson(Map<String?, dynamic> json) =>
      RecipeModelLinks();

  Map<String?, dynamic> toJson() => {};
}

class EnumValues<T> {
  Map<String?, T> map;
  Map<T, String?>? reverseMap;

  EnumValues(this.map);

  Map<T, String?>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
