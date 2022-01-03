// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

import 'dart:convert';

RecipeModel recipeModelFromJson(String str) =>
    RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  RecipeModel({
    required this.from,
    required this.to,
    required this.count,
    required this.links,
    required this.hits,
  });

  int from;
  int to;
  int count;
  RecipeModelLinks links;
  List<Hit> hits;

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        from: json["from"],
        to: json["to"],
        count: json["count"],
        links: RecipeModelLinks.fromJson(json["_links"]),
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "count": count,
        "_links": links.toJson(),
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
      };
}

class Hit {
  Hit({
    required this.recipe,
    required this.links,
  });

  Recipe recipe;
  HitLinks links;

  factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        recipe: Recipe.fromJson(json["recipe"]),
        links: HitLinks.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "recipe": recipe.toJson(),
        "_links": links.toJson(),
      };
}

class HitLinks {
  HitLinks({
    required this.self,
  });

  Next self;

  factory HitLinks.fromJson(Map<String, dynamic> json) => HitLinks(
        self: Next.fromJson(json["self"]),
      );

  Map<String, dynamic> toJson() => {
        "self": self.toJson(),
      };
}

class Next {
  Next({
    required this.href,
    required this.title,
  });

  String href;
  Title? title;

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        href: json["href"],
        title: titleValues.map[json["title"]],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "title": titleValues.reverse[title],
      };
}

enum Title { NEXT_PAGE, SELF }

final titleValues =
    EnumValues({"Next page": Title.NEXT_PAGE, "Self": Title.SELF});

class Recipe {
  Recipe({
    required this.uri,
    required this.label,
    required this.image,
    required this.images,
    required this.source,
    required this.url,
    required this.shareAs,
    required this.recipeYield,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautions,
    required this.ingredientLines,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
    required this.cuisineType,
    required this.mealType,
    required this.dishType,
    required this.totalNutrients,
    required this.totalDaily,
    required this.digest,
  });

  String uri;
  String label;
  String image;
  Images images;
  String source;
  String url;
  String shareAs;
  int recipeYield;
  List<String> dietLabels;
  List<String> healthLabels;
  List<String> cautions;
  List<String> ingredientLines;
  List<Ingredient> ingredients;
  double calories;
  double totalWeight;
  int totalTime;
  List<String> cuisineType;
  List<MealType> mealType;
  List<String> dishType;
  Map<String, Total> totalNutrients;
  Map<String, Total> totalDaily;
  List<Digest> digest;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        uri: json["uri"],
        label: json["label"],
        image: json["image"],
        images: Images.fromJson(json["images"]),
        source: json["source"],
        url: json["url"],
        shareAs: json["shareAs"],
        recipeYield: json["yield"],
        dietLabels: List<String>.from(json["dietLabels"].map((x) => x)),
        healthLabels: List<String>.from(json["healthLabels"].map((x) => x)),
        cautions: List<String>.from(json["cautions"].map((x) => x)),
        ingredientLines:
            List<String>.from(json["ingredientLines"].map((x) => x)),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
        calories: json["calories"].toDouble(),
        totalWeight: json["totalWeight"].toDouble(),
        totalTime: json["totalTime"],
        cuisineType: List<String>.from(json["cuisineType"].map((x) => x)),
        mealType: List<MealType>.from(
            json["mealType"].map((x) => mealTypeValues.map[x])),
        dishType: List<String>.from(json["dishType"].map((x) => x)),
        totalNutrients: Map.from(json["totalNutrients"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
        totalDaily: Map.from(json["totalDaily"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
        digest:
            List<Digest>.from(json["digest"].map((x) => Digest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "label": label,
        "image": image,
        "images": images.toJson(),
        "source": source,
        "url": url,
        "shareAs": shareAs,
        "yield": recipeYield,
        "dietLabels": List<dynamic>.from(dietLabels.map((x) => x)),
        "healthLabels": List<dynamic>.from(healthLabels.map((x) => x)),
        "cautions": List<dynamic>.from(cautions.map((x) => x)),
        "ingredientLines": List<dynamic>.from(ingredientLines.map((x) => x)),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "calories": calories,
        "totalWeight": totalWeight,
        "totalTime": totalTime,
        "cuisineType": List<dynamic>.from(cuisineType.map((x) => x)),
        "mealType":
            List<dynamic>.from(mealType.map((x) => mealTypeValues.reverse[x])),
        "dishType": List<dynamic>.from(dishType.map((x) => x)),
        "totalNutrients": Map.from(totalNutrients)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "totalDaily": Map.from(totalDaily)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "digest": List<dynamic>.from(digest.map((x) => x.toJson())),
      };
}

class Digest {
  Digest({
    required this.label,
    required this.tag,
    required this.schemaOrgTag,
    required this.total,
    required this.hasRdi,
    required this.daily,
    required this.unit,
    required this.sub,
  });

  String label;
  String tag;
  SchemaOrgTag? schemaOrgTag;
  double total;
  bool hasRdi;
  double daily;
  Unit? unit;
  List<Digest>? sub;

  factory Digest.fromJson(Map<String, dynamic> json) => Digest(
        label: json["label"],
        tag: json["tag"],
        schemaOrgTag: json["schemaOrgTag"] == null
            ? null
            : schemaOrgTagValues.map[json["schemaOrgTag"]],
        total: json["total"].toDouble(),
        hasRdi: json["hasRDI"],
        daily: json["daily"].toDouble(),
        unit: unitValues.map[json["unit"]],
        sub: json["sub"] == null
            ? null
            : List<Digest>.from(json["sub"].map((x) => Digest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "tag": tag,
        "schemaOrgTag": schemaOrgTag == null
            ? null
            : schemaOrgTagValues.reverse[schemaOrgTag],
        "total": total,
        "hasRDI": hasRdi,
        "daily": daily,
        "unit": unitValues.reverse[unit],
        "sub": sub == null
            ? null
            : List<dynamic>.from(sub!.map((x) => x.toJson())),
      };
}

enum SchemaOrgTag {
  FAT_CONTENT,
  CARBOHYDRATE_CONTENT,
  PROTEIN_CONTENT,
  CHOLESTEROL_CONTENT,
  SODIUM_CONTENT,
  SATURATED_FAT_CONTENT,
  TRANS_FAT_CONTENT,
  FIBER_CONTENT,
  SUGAR_CONTENT
}

final schemaOrgTagValues = EnumValues({
  "carbohydrateContent": SchemaOrgTag.CARBOHYDRATE_CONTENT,
  "cholesterolContent": SchemaOrgTag.CHOLESTEROL_CONTENT,
  "fatContent": SchemaOrgTag.FAT_CONTENT,
  "fiberContent": SchemaOrgTag.FIBER_CONTENT,
  "proteinContent": SchemaOrgTag.PROTEIN_CONTENT,
  "saturatedFatContent": SchemaOrgTag.SATURATED_FAT_CONTENT,
  "sodiumContent": SchemaOrgTag.SODIUM_CONTENT,
  "sugarContent": SchemaOrgTag.SUGAR_CONTENT,
  "transFatContent": SchemaOrgTag.TRANS_FAT_CONTENT
});

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
    required this.thumbnail,
    required this.small,
    required this.regular,
    required this.large,
  });

  Regular thumbnail;
  Regular small;
  Regular regular;
  Regular? large;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumbnail: Regular.fromJson(json["THUMBNAIL"]),
        small: Regular.fromJson(json["SMALL"]),
        regular: Regular.fromJson(json["REGULAR"]),
        large: json["LARGE"] == null ? null : Regular.fromJson(json["LARGE"]),
      );

  Map<String, dynamic> toJson() => {
        "THUMBNAIL": thumbnail.toJson(),
        "SMALL": small.toJson(),
        "REGULAR": regular.toJson(),
        "LARGE": large == null ? null : large!.toJson(),
      };
}

class Regular {
  Regular({
    required this.url,
    required this.width,
    required this.height,
  });

  String url;
  int width;
  int height;

  factory Regular.fromJson(Map<String, dynamic> json) => Regular(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}

class Ingredient {
  Ingredient({
    required this.text,
    required this.quantity,
    required this.measure,
    required this.food,
    required this.weight,
    required this.foodCategory,
    required this.foodId,
    required this.image,
  });

  String text;
  double quantity;
  String measure;
  String food;
  double weight;
  String foodCategory;
  String foodId;
  String image;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        text: json["text"],
        quantity: json["quantity"].toDouble(),
        measure: json["measure"] == null ? null : json["measure"],
        food: json["food"],
        weight: json["weight"].toDouble(),
        foodCategory:
            json["foodCategory"] == null ? null : json["foodCategory"],
        foodId: json["foodId"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "quantity": quantity,
        "measure": measure == null ? null : measure,
        "food": food,
        "weight": weight,
        "foodCategory": foodCategory == null ? null : foodCategory,
        "foodId": foodId,
        "image": image == null ? null : image,
      };
}

enum MealType { LUNCH_DINNER, BREAKFAST, SNACK }

final mealTypeValues = EnumValues({
  "breakfast": MealType.BREAKFAST,
  "lunch/dinner": MealType.LUNCH_DINNER,
  "snack": MealType.SNACK
});

class Total {
  Total({
    required this.label,
    required this.quantity,
    required this.unit,
  });

  String label;
  double quantity;
  Unit? unit;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        label: json["label"],
        quantity: json["quantity"].toDouble(),
        unit: unitValues.map[json["unit"]],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "quantity": quantity,
        "unit": unitValues.reverse[unit],
      };
}

class RecipeModelLinks {
  RecipeModelLinks({
    required this.next,
  });

  Next next;

  factory RecipeModelLinks.fromJson(Map<String, dynamic> json) =>
      RecipeModelLinks(
        next: Next.fromJson(json["next"]),
      );

  Map<String, dynamic> toJson() => {
        "next": next.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
