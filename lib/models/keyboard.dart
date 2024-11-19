// To parse this JSON data, do
//
//     final keyboard = keyboardFromJson(jsonString);

import 'dart:convert';

List<Keyboard> keyboardFromJson(String str) => List<Keyboard>.from(json.decode(str).map((x) => Keyboard.fromJson(x)));

String keyboardToJson(List<Keyboard> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Keyboard {
    String model;
    String pk;
    Fields fields;

    Keyboard({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Keyboard.fromJson(Map<String, dynamic> json) => Keyboard(
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
    DateTime createdAt;
    DateTime updatedAt;
    String fieldsSwitch;
    String brand;
    String image;
    int author;

    Fields({
        required this.name,
        required this.price,
        required this.description,
        required this.stock,
        required this.createdAt,
        required this.updatedAt,
        required this.fieldsSwitch,
        required this.brand,
        required this.image,
        required this.author,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fieldsSwitch: json["switch"],
        brand: json["brand"],
        image: json["image"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "stock": stock,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "switch": fieldsSwitch,
        "brand": brand,
        "image": image,
        "author": author,
    };
}
