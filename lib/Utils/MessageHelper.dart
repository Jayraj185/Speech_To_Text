import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:spt/Screens/HomeScreen/Controller/HomeController.dart';

class MessageHelper
{
  MessageHelper._();
  static MessageHelper messageHelper = MessageHelper._();
  HomeController homeController = Get.put(HomeController());


  Widget AnswerMessage({required String msg})
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: Get.width/30),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.2),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8),topLeft: Radius.circular(8))
                ),
                padding: EdgeInsets.all(15),
                // alignment: Alignment.center,
                child: msg.isNotEmpty ? Text(
                  "$msg",
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    fontSize: 18
                  ),
                ) : Lottie.asset("assets/animation/loading.json"),
              ),
            ),
            SizedBox(width: Get.width/30,),
          ],
        ),
        SizedBox(height: Get.width/60,),
        msg.isNotEmpty ? InkWell(
            onTap: () async {
              await homeController.flutterTts.speak(msg);
            },
            child: Icon(Icons.volume_up_sharp,color: Colors.white,),
        ) : Text("")
      ],
    );
  }

  Widget MyMessage({required String msg})
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: Get.width/30,),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: Get.width/30),
                decoration: const BoxDecoration(
                  color: Color(0xFF10A37F),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                ),
                padding: EdgeInsets.all(15),
                // alignment: Alignment.center,
                child: Text(
                  "$msg",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Get.width/60,),

        msg.isNotEmpty ? InkWell(
          onTap: () async {
            await homeController.flutterTts.speak(msg);
          },
            child: Icon(Icons.volume_up_sharp,color: Colors.white,),
        ) : Text("")
      ],
    );
  }
}