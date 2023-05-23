import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spt/Screens/HomeScreen/Controller/HomeController.dart';
import 'package:spt/Screens/HomeScreen/Model/AnswerModel.dart';
import 'package:spt/Utils/ApiHelper.dart';
import 'package:spt/Utils/MessageHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(15),
            child: Divider(color: Color.fromRGBO(255, 255, 255, 0.34),thickness: 0.5),
          ),
          title: const Text("Chat GPT",style: TextStyle(color: Colors.white),),
          backgroundColor: const Color(0xFF343541),
        ),
        backgroundColor: const Color(0xFF343541),
        // body: Center(
        //   child: Obx(() => Card(
        //         child: Container(
        //             width: Get.width / 1.09,
        //             height: Get.height / 3,
        //             child: Stack(
        //               children: [
        //                 Align(
        //                   alignment: Alignment.center,
        //                   child: Text(
        //                     "${homeController.text.value}",
        //                     textAlign: TextAlign.center,
        //                     maxLines: 30,
        //                     style: TextStyle(
        //                         color: Colors.black,
        //                         fontWeight: FontWeight.bold,
        //                         overflow: TextOverflow.ellipsis),
        //                   ),
        //                 ),
        //                 Align(
        //                   alignment: Alignment.bottomRight,
        //                   child: Padding(
        //                     padding: EdgeInsets.only(right: 6, bottom: 6),
        //                     child: IconButton(
        //                       onPressed: () async {
        //                         if (homeController.text.isNotEmpty) {
        //                           await homeController.flutterTts
        //                               .speak(homeController.text.value);
        //                         } else {
        //                           Get.snackbar("Alert", "Please Speak Any Things");
        //                         }
        //                       },
        //                       icon: Icon(
        //                         Icons.volume_up_sharp,
        //                         color: Colors.blue,
        //                         size: 30,
        //                       ),
        //                     ),
        //                   ),
        //                 )
        //               ],
        //             )),
        //       )),
        // ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width/30),
                child: Obx(
                  () => homeController.Chats.isNotEmpty ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homeController.Chats.length,
                    itemBuilder: (context, index) {
                      print("object====== $index");
                      return homeController.Chats[index].uid == 1 ? MessageHelper.messageHelper.AnswerMessage(msg: homeController.Chats[index].message!) : MessageHelper.messageHelper.MyMessage(msg: homeController.Chats[index].message!);
                    },
                  ) : Center(child: Text(
                    "Ask anything, get yout answer",
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(255, 255, 255, 0.4),
                      fontSize: 18
                    ),
                  ),),
                ),
              ),
            ),
            Container(
              height: Get.width/6,
              margin: EdgeInsets.only(left: Get.width/30,right: Get.width/30,bottom: Get.width/15,top: Get.width/30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.34),width: 2)
              ),
              padding: EdgeInsets.all(Get.width/45),
              alignment: Alignment.center,
              child: Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: homeController.txtMessage,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width/30,),
                    InkWell(
                      onTap: () async {
                        if (!homeController.isListne.value) {
                          bool available = await homeController.speechToText.initialize();
                          if (available) {
                            homeController.isListne.value = true;
                            homeController.speechToText.listen(
                              listenFor: const Duration(seconds: 30),
                              pauseFor: const Duration(seconds: 15),
                              listenMode: ListenMode.deviceDefault,
                              onResult: (result) {
                                homeController.txtMessage = TextEditingController(text: "");
                                if (result.finalResult) {
                                  homeController.isListne.value = false;
                                }
                                print("========== ${result.recognizedWords}");
                                homeController.txtMessage = TextEditingController(text: result.recognizedWords);
                              },
                            );
                          }
                        } else {
                          homeController.isListne.value = false;
                          homeController.speechToText.stop();
                        }
                      },
                      child: AvatarGlow(
                        endRadius: 30,
                        animate: homeController.isListne.value,
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        glowColor: Colors.blue,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        child: Container(
                          width: Get.width/9,
                          decoration: BoxDecoration(
                            color: const Color(0xFF10A37F),
                            borderRadius: BorderRadius.circular(6)
                          ),
                          alignment: Alignment.center,
                          child: Image.asset("assets/image/mic.png",height: Get.width/15,width: Get.width/15,),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                       if(homeController.txtMessage.text.isNotEmpty)
                         {
                           String msg = homeController.txtMessage.text;
                           homeController.txtMessage.clear();
                           homeController.Chats.add(MessageModel(uid: 0,message: msg));
                           homeController.Chats.add(MessageModel(uid: 1,message: ""));
                           await ApiHelper.apiHelper.AskQuestion(Question: msg).then((value) {
                             homeController.Chats[homeController.Chats.length - 1] = MessageModel(uid: 1,message: value!.answer);
                           });
                         }
                      },
                      child: Container(
                        width: Get.width/9,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10A37F),
                          borderRadius: BorderRadius.circular(6)
                        ),
                        alignment: Alignment.center,
                        child: Image.asset("assets/image/send.png",height: Get.width/15,width: Get.width/15,),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Obx(
        //   () => AvatarGlow(
        //     endRadius: 75.0,
        //     animate: homeController.isListne.value,
        //     duration: const Duration(milliseconds: 2000),
        //     repeat: true,
        //     showTwoGlows: true,
        //     glowColor: Colors.blue,
        //     repeatPauseDuration: const Duration(milliseconds: 100),
        //     child: FloatingActionButton(
        //       onPressed: () async {
        //         if (!homeController.isListne.value) {
        //           bool available =
        //               await homeController.speechToText.initialize();
        //           if (available) {
        //             homeController.isListne.value = true;
        //             homeController.speechToText.listen(
        //               listenFor: const Duration(seconds: 30),
        //               pauseFor: const Duration(seconds: 15),
        //               listenMode: ListenMode.deviceDefault,
        //               onResult: (result) {
        //                 homeController.text.value = "";
        //                 if (result.finalResult) {
        //                   homeController.isListne.value = false;
        //                 }
        //                 homeController.text.value = result.recognizedWords;
        //               },
        //             );
        //           }
        //         } else {
        //           homeController.isListne.value = false;
        //           homeController.speechToText.stop();
        //         }
        //       },
        //       child:
        //           Icon(!homeController.isListne.value ? Icons.mic : Icons.stop),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
