// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';

Product welcomeFromMap(String str) => Product.fromMap(json.decode(str));

String welcomeToMap(Product data) => json.encode(data.toMap());

class Product {
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? category;
  final String? owner;

  Product({
    this.name,
    this.description,
    this.price,
    this.image,
    this.category,
    this.owner,
  });

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        category: json["category"],
        owner: json["owner"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "category": category,
        "owner": owner,
      };
}
