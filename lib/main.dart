import 'package:flutter/material.dart';
import 'package:spt/Screens/HomeScreen/View/HomePage.dart';

void main()
{
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => HomePage()
        },
      )
  );
}