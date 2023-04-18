
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  CustomTextField({this.controller, this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[400] as Color,
          width: 1.2
        )
      ),
      padding: EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 10,
        right: 10
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          isDense: true,
          labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 18
          ),
          hintStyle: TextStyle(
            color: Colors.grey[300],
            fontSize: 18
          )
        ),
      ),
    );
  }
}
