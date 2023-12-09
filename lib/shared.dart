import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


dynamic promptPages = [
 
];

InputDecoration decorationStyles = InputDecoration(
    border: InputBorder.none,
    filled: false,
    fillColor:  HexColor("#2E2C30"),
    labelStyle: TextStyle(color: Colors.white),
    hintStyle: TextStyle(color: Colors.grey.shade700),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
      borderRadius: BorderRadius.circular(10)
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
      borderRadius: BorderRadius.circular(10)
    ),
    enabledBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade700, width: 0.5),
      borderRadius: BorderRadius.circular(10)
    ),

);