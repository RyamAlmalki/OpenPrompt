import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? url;
  TextEditingController textForm = TextEditingController();
  String? queryText;


  final List<Map<String, String>> messages = [];
  String OpenAiKey = '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';

  Future<String> chatGPTAPI(String prompt) async {
      messages.add({
        'role': 'user',
        'content': prompt,
      });
      try {
        final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $OpenAiKey',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messages,
          }),
        );

        if (res.statusCode == 200) {
          String content =
              jsonDecode(res.body)['choices'][0]['message']['content'];
          content = content.trim();

          messages.add({
            'role': 'assistant',
            'content': content,
          });
          return content;
        }
        return 'An internal error occurred';
      } catch (e) {
        return e.toString();
      }
    }

  // Future getData(url) async {
  //   var uri = Uri.parse(url); 
  //   Response response = await get(uri);
  //   return response.body;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
               Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      queryText ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: TextFormField(
                    // onChanged: (value) {
                    //   url = "http://127.0.0.1:5000/api?Query=${textForm.text}";
                    // },
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.text,
                    controller: textForm,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                        icon: const Icon(Icons.search), 
                        onPressed: () async {
                          var data = await chatGPTAPI(textForm.text);
                          // var decodedData = jsonDecode(data);
                          setState(() {
                            queryText = data;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.black,
                      hintStyle: TextStyle(color: Colors.black),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}