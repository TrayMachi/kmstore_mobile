// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    String pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    String? fieldsSwitch;
    String brand;
    String image;
    int author;
    int? dpi;
    int? weight;

    Fields({
        required this.name,
        required this.price,
        required this.description,
        required this.stock,
        required this.createdAt,
        required this.updatedAt,
        this.fieldsSwitch,
        required this.brand,
        required this.image,
        required this.author,
        this.dpi,
        this.weight,
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
        dpi: json["dpi"],
        weight: json["weight"],
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
        "dpi": dpi,
        "weight": weight,
    };
}
