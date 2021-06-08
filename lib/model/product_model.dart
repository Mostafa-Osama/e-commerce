import 'package:flutter/material.dart';

class ProductModel {
  String name;
  String image;
  String price;
  String oldPrice;

  ProductModel(
      {@required this.name,
        @required this.image,
        @required this.price,
        @required this.oldPrice,
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    image = json['image'];
    price = json['price'];
    oldPrice = json['old price'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'old price': oldPrice,
    };
  }
}
