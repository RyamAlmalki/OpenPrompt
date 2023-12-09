import 'package:flutter/material.dart';
import 'package:login_and_register/model/prompt.dart';
import 'package:login_and_register/screens/homepage_screen.dart';
import 'package:login_and_register/shared.dart';
import 'package:login_and_register/screens/image_generator_screen.dart';

class CreateBotScreen extends StatefulWidget {
  const CreateBotScreen({super.key});

  @override
  State<CreateBotScreen> createState() => _CreateBotScreenState();
}

class _CreateBotScreenState extends State<CreateBotScreen> {
  Color appBarColor = Colors.transparent;
  TextEditingController handelForm = TextEditingController();
  TextEditingController promptForm = TextEditingController();
  TextEditingController greetingForm = TextEditingController();
  TextEditingController bioForm = TextEditingController();
  bool isCreated = false;
  dynamic imageUrl;

  creatBot() async {
    // loading CircularProgress 
    showDialog(
      context: context, 
      builder: (context){
        return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent,));
      }
    );

    if(handelForm.text.isNotEmpty && promptForm.text.isNotEmpty){
      if(handelForm.text.length <= 20){

        promptPages.add(Prompt(handel: handelForm.text, bio: bioForm.text, prompt: promptForm.text, imageUrl: imageUrl, greeting: greetingForm.text));
        
        setState(() {
          isCreated = true;
        });

      }
    }
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text("Create a bot", style: TextStyle(fontSize: 18),)
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: ( notification) {
           if (notification is ScrollUpdateNotification) {
              setState(() {
                appBarColor = notification.metrics.pixels > 0 ? Colors.grey.shade900 : Colors.transparent;
              });
            }

            return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),

                          // Bot Image 
                          SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.deepPurpleAccent,
                                    image: DecorationImage( fit: BoxFit.cover,image: imageUrl != null ? NetworkImage(imageUrl) : NetworkImage(''))
                                  ),
                                  height: 125,
                                  width: 125,
                                  child: TextButton(
                                    onPressed: () async {
                                        Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  const ImageGenerator()
                                          )
                                        ).then((value) => setState(() {
                                          imageUrl = value;
                                        }));
                                    },


                                    child: imageUrl != null ? const Icon(Icons.abc, color: Colors.transparent,) : const Icon(Icons.add_a_photo, color: Colors.white, size: 50,)
                                  ),
                                ),
                              ],
                            ),
                          ),
        
                          const SizedBox(
                            height: 50,
                          ),
                          
                          // Bot Handle 
                          SizedBox(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Handel", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                controller: handelForm,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: 'Text Expander', 
                                  )
                                ),
                              ],
                            ),
                          ),
        
                          const SizedBox(
                            height: 20,
                          ),
        
                          // Bot prompt 
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Prompt", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                controller: promptForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: 'Expand upon the given text, providing additional details, explanations, or examples. Elaborate on key points and explore related concepts to provide a comprehensive and thorough expansion of the original text.', 
                                  )
                                ),
                              ],
                            ),
                          ),  
        
                          const SizedBox(
                            height: 20,
                          ),
        
                          // Greeting message 
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Greeting Message", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                controller: greetingForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: 'Welcome to Text Expander 🤖✨ To get started, simply type your chosen text, and Text Expander will do the rest.', 
                                  )
                                ),
                              ],
                            ),
                          ),
        
                          const SizedBox(
                            height: 20,
                          ),
                          // Bot bio
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Bot Bio", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                controller: bioForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: 'Meet Text Expander, your typing revolution! From short phrases to longer snippets, Text Expander transforms your text, making communication swift and efficient 😎', 
                                  )
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ),
                  ) 
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
                        await creatBot();

                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);

                        if(isCreated){
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen(promptPages: promptPages,)
                            ),
                          );
                        }
                         
                      }, 
                    child: const Text('Create Bot', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


