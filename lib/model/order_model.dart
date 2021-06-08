import 'package:flutter/material.dart';

class OrderModel {
  double grandPrice;
 // List<dynamic> order = [];
  OrderInfo order;


  OrderModel(
      {@required this.grandPrice,
        @required this.order,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    grandPrice = json['grand price'];
    order = OrderInfo.fromJson(json['order info']);

  //  order.add(json['order info']);
  }

}

class OrderInfo{
  List<Order> order = [];

  OrderInfo.fromJson(Map<String,dynamic> json){
    json['0'].forEach((element) {

      order.add(element);
    });
  }
}


class Order{
  String name;
  int qty;

  Order.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
  }
}
