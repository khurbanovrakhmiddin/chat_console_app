import 'dart:convert';

import 'package:chat_console_app/model/message_model.dart';
import 'package:chat_console_app/model/users_model.dart';
import 'package:http/http.dart';


class NetworkService {
  // URL
  static const String baseUrl = "6267cc7c01dab900f1c52ad8.mockapi.io";

  // HEADERS
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // APIS
  static const String apiUsers = "/tg/api/v1/users";

  static const String apiMessages = "/tg/api/v1/message";

  // METHODS
  static Future<String> GET(String api, Map<String, String> headers) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response = await get(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {

      return "404";

    }
  }

  static Future<String> POST(String api, Map<String, String> headers,
      Map<String, dynamic> body) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response =
        await post(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Error");
    }
  }

  static Future<String> PUT(String api, Map<String, String> headers,
      Map<String, dynamic> body) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response =
        await put(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Error");
    }
  }

  static Future<String> PATCH(String api, Map<String, String> headers,
      Map<String, dynamic> body) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response =
        await patch(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception("Error");
    }
  }

  static Future<String> DELETE(String api, Map<String, String> headers) async {
    Uri uri = Uri.https(baseUrl, api);
    Response response = await delete(uri, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      print(response.statusCode);
      return response.body;
    }
  }



  static List<User> parseUsers(List res)  {
    List<User> result = res.map((e) => User.fromJson(e)).toList();
    return result;
  }

static  Future <List<Message> >parseMessage(List list)async{
    List<Message> msg = list.map((e) => Message.fromJson(e)).toList();
    return msg;
  }
}
