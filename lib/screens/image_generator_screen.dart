import 'package:flutter/material.dart';
import 'package:login_and_register/services/chatgpt.dart';
import 'package:login_and_register/shared.dart';


class ImageGenerator extends StatefulWidget {
  const ImageGenerator({super.key});

  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  final TextEditingController _textController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Image Generation', style: TextStyle(fontSize: 18),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bot Handle 
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Image", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                    maxLines: 5,
                    controller: _textController,
                    textAlignVertical: TextAlignVertical.top,
                    scrollPadding: const EdgeInsets.only(bottom: 30),
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      decoration: decorationStyles.copyWith(
                        alignLabelWithHint: true,
                        hintText: '3d icon image of a pen', 
                      )
                    ),
                  ],
                ),
              ),
            ),

            // Save Button 
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                onPressed: () async{
                  // loading CircularProgress 
                  showDialog(
                    context: context, 
                    builder: (context){
                      return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent,));
                    }
                  );

                  dynamic generatedImageUrl = await ChatGPT().generateImage(_textController.text);

                  if (generatedImageUrl != null){
                    Navigator.pop(context);
                    Navigator.pop(context, generatedImageUrl);
                  }
                      
                  }, 
                child: const Text('Generate Image', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}