import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spt/Screens/HomeScreen/Controller/HomeController.dart';
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width/30),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return MessageHelper.messageHelper.MyMessage(msg: "${index+1}");
                },
              ),
            ),
            Spacer(),
            Container(
              height: Get.width/6,
              margin: EdgeInsets.only(left: Get.width/30,right: Get.width/30,bottom: Get.width/15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromRGBO(255, 255, 255, 0.1),
                border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.34),width: 2)
              ),
              padding: EdgeInsets.all(Get.width/45),
              alignment: Alignment.center,
              child: Row(
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
                    onTap: () {

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
