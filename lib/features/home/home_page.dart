import 'package:flutter/material.dart';
import 'package:http/http.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? responseBody;

  Future getData(uri) async {
    var url = Uri.parse(uri); 
    Response response = await get(url);
    print(response.body);
    responseBody = response.body;
  }

  @override
  void initState() {
    getData("http://127.0.0.1:5000");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
               Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      responseBody ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.amber),
                    ),
                  ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}