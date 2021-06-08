import 'package:flutter/material.dart';

class AddressModel {
  String name;
  String city;
  String street;
  String building;
  String floor;
  String apartment;
  bool status;

  AddressModel(
      {@required this.name,
        @required this.city,
        @required this.street,
        @required this.building,
        @required this.floor,
        @required this.apartment
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    street = json['street'];
    building = json['building'];
    floor = json['floor'];
    apartment = json['apartment'];
    status = json['status'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'street': street,
      'building': building,
      'floor':floor,
      'apartment':apartment,
      'status':status,
    };
  }
}
