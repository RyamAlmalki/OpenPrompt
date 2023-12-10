import 'package:flutter/material.dart';
import 'package:login_and_register/model/prompt.dart';
import 'package:login_and_register/screens/homepage_screen.dart';
import 'package:login_and_register/shared.dart';

class BotProfileScreen extends StatefulWidget {
  BotProfileScreen({super.key, required this.prompt});
  Prompt? prompt;

  @override
  State<BotProfileScreen> createState() => _BotProfileScreenState();
}

class _BotProfileScreenState extends State<BotProfileScreen> {
  Color appBarColor = Colors.transparent;
  TextEditingController handelForm = TextEditingController();
  TextEditingController promptForm = TextEditingController();
  TextEditingController greetingForm = TextEditingController();
  TextEditingController bioForm = TextEditingController();
  bool isCreated = false;
  dynamic imageUrl;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        title: const Text("My Bot", style: TextStyle(fontSize: 18),)
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
                                    image: DecorationImage( fit: BoxFit.cover,image: widget.prompt!.imageUrl != null ? NetworkImage(widget.prompt!.imageUrl ?? "") : NetworkImage(''))
                                  ),
                                  height: 125,
                                  width: 125,
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
                                    Text("Handel", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                enabled: false,
                                controller: handelForm,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: '${widget.prompt!.handel}', 
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
                                    Text("Prompt", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                enabled: false,
                                controller: promptForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: '${widget.prompt!.prompt}', 
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
                                    Text("Greeting Message", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                enabled: false,
                                controller: greetingForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: '${widget.prompt!.greeting}', 
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
                                    Text("Bot Bio", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                enabled: false,
                                controller: bioForm,
                                maxLines: 5,
                                textAlignVertical: TextAlignVertical.top,
                                scrollPadding: const EdgeInsets.only(bottom: 30),
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.text,
                                  decoration: decorationStyles.copyWith(
                                    alignLabelWithHint: true,
                                    hintText: '${widget.prompt!.bio}', 
                                  )
                                ),
                              ],
                            ),
                          ),

                        // Save Button 
 
                          Padding(
                            padding: const EdgeInsets.only( top: 10),
                            child: SizedBox(
                              height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                onPressed: () async {
                                  promptPages.remove(widget.prompt);
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomeScreen(promptPages: promptPages,)
                                  ),);

                                }, 
                              child: const Text('Remove Bot', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                              )
                            ),
                          ),

                         const SizedBox(
                            height: 100,
                          )
                        ],
                      )
                    ),
                  ) 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}