import 'package:flutter/material.dart';
import 'package:login_and_register/screens/create_bot_screen.dart';
import 'package:login_and_register/screens/message_screens.dart';
import 'package:login_and_register/shared.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, this.promptPages});
  dynamic promptPages;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Bots", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const CreateBotScreen()
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 30,),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            mainAxisExtent: 200,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0
          ),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: promptPages.length,
          itemBuilder: (BuildContext context, int index) {  
            return Padding(
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            child: GestureDetector(
              onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MessageScreen(isBot: false, prompt: promptPages[index],)
                  ),
                );
              },
              child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                 height: 100,
                                 width: 100,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   image: DecorationImage( fit: BoxFit.cover,image: promptPages[index].imageUrl != null ? NetworkImage(promptPages[index].imageUrl)  : const NetworkImage(''))
                                 ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(promptPages[index].handel, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                              ],
                            ),
                            const SizedBox(height: 4,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(promptPages[index].bio ?? "", style: TextStyle(color: Colors.grey.shade100, fontWeight: FontWeight.normal),),
                              ],
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              )
            );
          }
        )
      ),
    );
  }
}