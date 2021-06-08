import 'package:flutter/material.dart';

Widget buildTextFormField({
  @required TextInputType keyboardType,
  IconData prefixIcon,
  IconData suffixIcon,
  @required String hintText,
  @required Color hintColor,
  @required double borderRadius,
  @required bool filled,
  @required Color fillColor,
  @required TextEditingController controller,
  Function onSuffixPressed,
  bool obscure = false,

}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscure,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      suffixIcon: IconButton(icon:Icon(suffixIcon),onPressed: onSuffixPressed,),
      hintText: hintText,
      hintStyle: TextStyle(color:hintColor ),
      filled: filled,
      fillColor: fillColor,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none),
    ),
  );
}

Widget buildTextField({
  @required String labelText,
  Color color = Colors.grey,
  @required TextInputType keyboardType,
  double radius = 10,
  TextEditingController controller,
  String initialValue,

}){
  return TextFormField
    (
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      labelText: labelText,
      hintStyle: TextStyle(color: color),

    ),
    keyboardType: keyboardType,
    controller: controller,
    initialValue: initialValue,
  );
}


void push(context,Widget widget){
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => widget));
}

void pushReplace(context,Widget widget){
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) => widget));
}

