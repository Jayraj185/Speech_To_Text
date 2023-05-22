import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageHelper
{
  MessageHelper._();
  static MessageHelper messageHelper = MessageHelper._();


  Widget MyMessage({required String msg})
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF10A37F),
              borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8))
            ),
            padding: EdgeInsets.all(15),
            // alignment: Alignment.center,
            child: Text(
              "$msg",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ),
        SizedBox(width: Get.width/60,),
      ],
    );
  }
}