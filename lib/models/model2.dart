// To parse this JSON data, do
//
//     final categoryitem = categoryitemFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Categoryitem categoryitemFromJson(String str) =>
    Categoryitem.fromJson(json.decode(str));

String categoryitemToJson(Categoryitem data) => json.encode(data.toJson());

class Categoryitem {
  final List<Category> categories;

  Categoryitem({
    required this.categories,
  });

  factory Categoryitem.fromJson(Map<String, dynamic> json) => Categoryitem(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class Category {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        idCategory: json["idCategory"],
        strCategory: json["strCategory"],
        strCategoryThumb: json["strCategoryThumb"],
        strCategoryDescription: json["strCategoryDescription"],
      );

  Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
}
