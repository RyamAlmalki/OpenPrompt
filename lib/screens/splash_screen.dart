import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_and_register/screens/homepage_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  
  _SplashScreenState(){
    Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()
          ),
        );
      });
    });

     Timer(
      const Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; 
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: MediaQuery.of(context).size.width / 1.2,
          color: Colors.black,
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0,
            duration: const Duration(milliseconds: 1200),
            child: Center(
              child: Image.asset('assets/logo2.png'),
            ),
          ),
        ),
      ],
    );
  }
}