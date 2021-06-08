import 'package:flutter/material.dart';

class CartModel {
  String name;
  String image;
  String price;
  String oldPrice;
  int quantity;
  String date;

  CartModel(
      {@required this.name,
        @required this.image,
        @required this.price,
        @required this.oldPrice,
        @required this.quantity,
        @required this.date
      });

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    image = json['image'];
    price = json['price'];
    oldPrice = json['old price'];
    quantity = json['quantity'];
    date = json['date'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'old price': oldPrice,
      'quantity':quantity,
      'date':date,
    };
  }
}
