import 'package:flutter/material.dart';

class OrderModel {
  double grandPrice;
  String date;
  Order order;


  OrderModel(
      {@required this.grandPrice,
        @required this.order,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    grandPrice = json['grandPrice'];
    date = json['dateTime'];
    order = Order.fromJson(json['orderInfo']);
    // print("order 0 = ${order.list[0].name}");
    // print("order 0 = ${order.list[0].qty}");
    // print("order 1 = ${order.list[1].name}");
    // print("order 1 = ${order.list[1].qty}");
  }


}



class Order{

 List<OrderInfo> list = [];

  Order.fromJson(List<dynamic> json) {

    json.forEach((element) {
      list.add(OrderInfo.fromJson(element));
    });

    // print('From Model');
    // print(list[0].name);
    // print(list[0].qty);
    // print(list[1].name);
    // print(list[1].qty);

  }


}




class OrderInfo{
  String name;
  String qty;
  String image;

  OrderInfo.fromJson(Map<String,dynamic> json){
    name = json['name'];
    qty = json['qty'];
    image = json['image'];
  }
}
