import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_and_register/model/message.dart';
import 'package:login_and_register/model/prompt.dart';
import 'package:login_and_register/screens/bot_profile_screen.dart';
import 'package:login_and_register/widget/progress_indicator.dart';
import 'package:login_and_register/services/chatgpt.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key, required this.isBot, this.prompt});
  bool isBot;
  Prompt? prompt;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, String>> messages = [];
  String? queryText;
  String? hintText = "Type your text...";
  TextEditingController textForm = TextEditingController();
  bool hasText = false;
  final ScrollController _controllerScroll = ScrollController();
  String? message;


  List<Message> messageInChat = [
    
  ];

  

    @override
  void initState() {
    messageInChat.add(Message(text: widget.prompt?.greeting, type: false));
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage( fit: BoxFit.cover,image: widget.prompt!.imageUrl != null ? NetworkImage(widget.prompt!.imageUrl ?? "")  : NetworkImage(''))
                  ),
                ),
                const SizedBox(width: 10,),
                Text("${widget.prompt?.handel}"),
              ],
            ),
            
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  BotProfileScreen(prompt: widget.prompt,)
                    )
                  ).then((value) => setState(() {
                }));
              },
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true, // assign true
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)), 
          color: Colors.black,),
          child: Column(
              //dmainAxisAlignment: MainAxisAlignment.spaceBetween,       
              children: [
                        
                  const SizedBox(height: 50,),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: false,
                        controller: _controllerScroll,
                          itemCount:  messageInChat.length,
                          itemBuilder: (BuildContext context, int index) {
                            return MessageBubble(message:  messageInChat[index], isMe: widget.isBot? false : messageInChat[index].type);
                          },
                      ),
                    ),
                  ),
                
                
              
                    Container(
                      height: 85,
                      decoration:BoxDecoration(
                      border: Border(
                        top: BorderSide(color: HexColor("#2E2C30")),
                        ),
                      ),
                      child: TextField(
                        enableInteractiveSelection: false,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                        value.isNotEmpty ? setState(() => hasText = true) : setState(() => hasText = false);
                      },
                      controller: textForm,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Colors.black,
                        filled: true,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: IconButton(icon: const Icon(Icons.send_rounded, color: Colors.white,), 
                            onPressed: () async {
                              
                        
                              setState(() {
                                messageInChat.add(Message(text: textForm.text, type: true));
                                message = textForm.text;
                              });

                              
                              textForm.clear();
                              hasText = false;

                              // Move the scroll position to the bottom
                              _controllerScroll.animateTo(
                                _controllerScroll.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              
                              
                              setState(() {
                                messageInChat.add(Message(type: false, loading: true));
                              });
                              
                              
                              var data = await ChatGPT().chatGPTAPI(widget.prompt!.prompt, message);
                              textForm.clear();
                              
                              setState(() {
                                messageInChat[messageInChat.length - 1].loading = false;
                                messageInChat[messageInChat.length - 1].text = data;
                                
                              });      
                            },
                          )
                        ),
                        hintText: hasText ? null : hintText,
                        hintStyle: const TextStyle(color: Colors.white),
                    
                   ),
                  ),
                ),
              ]
            )
        
        ),
      )
    );
  }
}



class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, required this.isMe});
  final Message message;
  final bool isMe;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, 
        children: [

           message.loading == true?  ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 3,
                maxHeight: MediaQuery.of(context).size.width / 6,
              ),
              child: Material(
              color: isMe? HexColor("#2E2C30"): Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only( topLeft: !isMe ? const Radius.circular(0.0): const Radius.circular(30.0), bottomRight: const Radius.circular(30.0), bottomLeft: const Radius.circular(30.0), topRight:  isMe ? const Radius.circular(0.0): const Radius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: JumpingDotsProgressIndicator(fontSize: 25, color: Colors.white,),
              ),
            ),
          ):

          ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5,
              ),
              child: Material(
              color: isMe? HexColor("#2E2C30"): Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only( topLeft: !isMe ? const Radius.circular(0.0): const Radius.circular(30.0), bottomRight: const Radius.circular(30.0), bottomLeft: const Radius.circular(30.0), topRight:  isMe ? const Radius.circular(0.0): const Radius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     message.loading == true? Center(
                       child: JumpingDotsProgressIndicator(fontSize: 40, color: Colors.white,)
                     ):  SelectableText(
                      '${message.text}', 
                      style: const TextStyle(color: Colors.white),
                    ) ,        
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


