import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController
{
  RxBool isListne = false.obs;
  SpeechToText speechToText = SpeechToText();
  RxString text = "Please Click Button & Speak Any Thing".obs;
  FlutterTts flutterTts = FlutterTts();
  RxList Chats = [].obs;
  TextEditingController txtMessage = TextEditingController();
}