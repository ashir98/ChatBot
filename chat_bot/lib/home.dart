import 'package:avatar_glow/avatar_glow.dart';
import 'package:chat_bot/model/chat_model.dart';
import 'package:chat_bot/service/api_service.dart';
import 'package:chat_bot/widget/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  String text = "Hold the button then start speaking";

  bool isActive = false;
  SpeechToText speechToText = SpeechToText(); 

  final List<ChatMessages> messages = []; 

  var scrollController = ScrollController();

  scrollMethod(){
    scrollController.animateTo(scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 3), curve: Curves.easeOut);
  }


  
  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
      appBar: AppBar(
        title: const Text("CHATBOT", style: TextStyle(letterSpacing: 5),),
        centerTitle: true,
      ),


      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 25),
        decoration: const BoxDecoration(
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(text,style: TextStyle(fontSize: 20, color: isActive?Colors.white:Colors.white70),)),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.black
                ),
                child: ListView.builder(
                  controller: ScrollController(),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    var chat = messages[index];
                    return chatBubble(
                      chatText: chat.text,
                      type: chat.type
                    );
                  },
                ),
              ),
            ),

          ],
        ),
      ),




      floatingActionButton: AvatarGlow(
        endRadius: 75,
        animate: isActive,
        glowColor: const Color.fromARGB(255, 188, 158, 240),
        duration: const Duration(seconds: 1),
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 50),
        showTwoGlows: true,
        startDelay: const Duration(milliseconds: 100),
        child: GestureDetector(

          onTapDown: (details) async{

            if(!isActive){
              var available = await speechToText.initialize();
              if(available){
                setState(() {
                  isActive = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        text = result.recognizedWords;
                      });
                    },

                  );
                });
              }
            }
          },


          onTapUp: (details)async {
            setState(() {
              isActive = false;  
            });
            speechToText.stop();


            messages.add(ChatMessages(text: text, type: ChatMessageType.user));

            var msg = await ApiService.sendMessage(text);


            setState(() {
              messages.add(ChatMessages(text: msg, type: ChatMessageType.bot));
            });
          },
          child: CircleAvatar(       
            radius: 35,     
            child: Icon(isActive?Icons.mic_rounded:Icons.mic_none_rounded),   
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}