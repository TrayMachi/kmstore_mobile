// To parse this JSON data, do
//
//     final mouse = mouseFromJson(jsonString);

import 'dart:convert';

List<Mouse> mouseFromJson(String str) => List<Mouse>.from(json.decode(str).map((x) => Mouse.fromJson(x)));

String mouseToJson(List<Mouse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mouse {
    String model;
    String pk;
    Fields fields;

    Mouse({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Mouse.fromJson(Map<String, dynamic> json) => Mouse(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    int price;
    String description;
    int stock;
    int dpi;
    DateTime createdAt;
    DateTime updatedAt;
    int weight;
    String brand;
    String image;
    int author;

    Fields({
        required this.name,
        required this.price,
        required this.description,
        required this.stock,
        required this.dpi,
        required this.createdAt,
        required this.updatedAt,
        required this.weight,
        required this.brand,
        required this.image,
        required this.author,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
        dpi: json["dpi"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        weight: json["weight"],
        brand: json["brand"],
        image: json["image"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "stock": stock,
        "dpi": dpi,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "weight": weight,
        "brand": brand,
        "image": image,
        "author": author,
    };
}
