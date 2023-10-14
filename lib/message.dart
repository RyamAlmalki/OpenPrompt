import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Previous page content
          Container(
            color: HexColor("#33B376"),
          ),
          // New page content almost at the top
          Positioned(
            top: 100, // Adjust the top position as needed
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), color: HexColor("#141414"),),
             
            ),
          ),
        ],
      ),
    );
  }
}