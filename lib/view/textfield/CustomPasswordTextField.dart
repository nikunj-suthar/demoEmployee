

import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  CustomPasswordTextField({this.controller, this.hintText});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: _obscureText,
              controller: widget.controller,
              decoration: InputDecoration(
                  hintText: widget.hintText,
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
          ),
          InkWell(
            onTap: (){
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ],
      ),
    );
  }
}

