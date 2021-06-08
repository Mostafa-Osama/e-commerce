import 'package:flutter/material.dart';

class UserModel {
  String name;
  String phone;
  String email;
  String uid;
  String photo;

  UserModel(
      {@required this.name,
      @required this.phone,
      @required this.email,
      @required this.uid,
      @required this.photo});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uid = json['uid'];
    photo = json['photo'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uid': uid,
      'photo': photo,
    };
  }
}
