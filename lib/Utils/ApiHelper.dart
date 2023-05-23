import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spt/Screens/HomeScreen/Model/HomeModel.dart';
class ApiHelper
{
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Future<HomeModel?> AskQuestion({required String Question})
  async {
    print("====== $Question");
    String apiLink = "https://simple-chatgpt-api.p.rapidapi.com/ask";
    var response = await http.post(
          Uri.parse(apiLink),
          body: jsonEncode({"question": Question}),
          headers: {
            "content-type" : "application/json",
            "X-RapidAPI-Key" : "1ffc10f215msh3a39e6357e70209p12737fjsn19fff83a639a",
            "X-RapidAPI-Host" : "simple-chatgpt-api.p.rapidapi.com",
          }
        );
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