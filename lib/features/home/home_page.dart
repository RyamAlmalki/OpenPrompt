import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'This is where the questions text will go',
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ),
               SizedBox(
                width: 500,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    child: const Text(
                      'False',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 500,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    child: const Text(
                      'True',
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      
                    },
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}