import 'package:http/http.dart' as http;
import 'package:login_and_register/api/api_key.dart';
import 'dart:convert';

class ChatGPT{
  String _generatedImageUrl = '';
  final List<Map<String, String>> messages = [];


  Future<String> chatGPTAPI(String? userprompt, String? message) async {
      messages.add({
        'role': 'user',
        'content': "Utilize the prompt $userprompt to process input enclosed within brackets [$message]. Generate the desired output based on the given input. Only display the answer, avoid asking questions, and focus solely on working within the constraints of this prompt",
      });

      try {
        final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $gptApiKey',
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


  Future<dynamic> generateImage(prompt) async {
    final String apiKey = gptApiKey; 

    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': prompt,
        "n": 1,
        "size": "512x512"
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
        _generatedImageUrl = responseData['data'][0]['url'];
        return _generatedImageUrl;
        
    } else {
      print('Error generating image: ${response.reasonPhrase}');
    }
  }
}

