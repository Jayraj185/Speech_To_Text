import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spt/Screens/HomeScreen/Model/HomeModel.dart';
class ApiHelper
{
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Future<HomeModel?> AskQuestion({required String Question})
  async {
    String apiLink = "https://simple-chatgpt-api.p.rapidapi.com/ask";
    Map body = {
      "question": Question
    };
    Map<String,String> headers = {
      "content-type" : "application/json",
      "X-RapidAPI-Key" : "d9f5b28687msh2be2959e965654dp1726d3jsna7e6e876b026",
      "X-RapidAPI-Host" : "simple-chatgpt-api.p.rapidapi.com",
    };
    var response = await http.post(Uri.parse(apiLink),body: body,headers: headers);
    if(response.statusCode == 200)
      {
        var json = jsonDecode(response.body);
        return HomeModel.fromJson(json);
      }
    else
      {
        return null;
      }
  }
}