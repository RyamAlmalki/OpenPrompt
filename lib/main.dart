import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_and_register/message.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyAnimatedText(
            sentence: "ince the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic. ndustry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic. ndustry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic. ndustry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic. ndustry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but the the leap.",
          )
    );
  }
}


class MyAnimatedText extends StatefulWidget {
  final String sentence;

  const MyAnimatedText({
    Key? key,
    required this.sentence,
  }) : super(key: key);

  @override
  State<MyAnimatedText> createState() => _MyAnimatedTextState();
}

class _MyAnimatedTextState extends State<MyAnimatedText> {
  late List<String> words = widget.sentence.split(" ").toList();
  List<bool> colored = [];
             

  late Timer timer;

  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < words.length; i++) {
      colored.add(false);
    }

    timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      activeIndex += 10;
      if (activeIndex > words.length){
        activeIndex = 0;
        timer.cancel();
        Navigator.of(context).push(_createRoute()); 
      }
       
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#33B376"),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, bottom: 100, right: 30, left: 30),
        child: Center(
          child: Stack(
            children: [
              // Positioned(
              //   top: MediaQuery.of(context).size.height / 3.5,
              //   right: MediaQuery.of(context).size.width / 3.5,
              //   child: Text("Az-Zada", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white),)
              //   ),
              Opacity(
                opacity: 0.4,
                child: RichText(
                    textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: () {
                      List<InlineSpan> spans = [];
                      
                      for (int i = 0; i < words.length; i++) {
                        if(i == activeIndex){
                          colored[i] = true;
                        }
                        spans.add(TextSpan(
                          text: words[i] + " ",
                          style: i == activeIndex || colored[i] == true
                              ? const TextStyle( //highlight style
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                )
                              : TextStyle(
                                  color: HexColor("#CACACA"),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w100
                                ),
                        ));
                      }
                
                      return spans;
                    }(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  NewPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

