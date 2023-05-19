import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:spt/Screens/HomeScreen/Controller/HomeController.dart';

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
          title: const Text("Speech To Text"),
        ),
        body: Center(
          child: Obx(() => Container(
            width: Get.width/1.5,
                  child: Text(
                "${homeController.text.value}",
                textAlign: TextAlign.center,
                maxLines: 30,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(
          () => AvatarGlow(
            endRadius: 75.0,
            animate: homeController.isListne.value,
            duration: const Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            glowColor: Colors.blue,
            repeatPauseDuration: const Duration(milliseconds: 100),
            child: FloatingActionButton(
              onPressed: () async {
                if (!homeController.isListne.value) {
                  bool available =
                      await homeController.speechToText.initialize();
                  if (available) {
                    homeController.isListne.value = true;
                    homeController.speechToText.listen(
                        listenFor: const Duration(seconds: 30),
                      pauseFor: const Duration(seconds: 15),
                      listenMode: ListenMode.deviceDefault,
                      onResult: (result) {
                        homeController.text.value = "";
                        if(result.finalResult)
                          {
                            homeController.isListne.value = false;
                          }
                        homeController.text.value = result.recognizedWords;
                      },
                    );
                  }
                } else {
                  homeController.isListne.value = false;
                  homeController.speechToText.stop();
                }
              },
              child:
                  Icon(!homeController.isListne.value ? Icons.mic : Icons.stop),
            ),
          ),
        ),
      ),
    );
  }
}