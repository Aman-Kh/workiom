import 'dart:convert';

import 'package:flutter_projects/constants/preference_keys.dart';
import 'package:flutter_projects/models/general_response.dart';
import 'package:http/http.dart' as web;
import 'package:shared_preferences/shared_preferences.dart';

class HttpService {
  Future<String?> httpGet(String stringUrl, {Map<String, String>? headers}) async {
    Uri uri = Uri.parse(stringUrl);
    web.Response response = await web.get(uri, headers: headers);
    if (response.statusCode != 200) {
      return null;
    }
    return response.body;
  }

  Future<String?> httpPost(String url, dynamic body, {needsAuth = true}) async {
    try{
      Uri uri = Uri.parse(url);
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString(emailToken);
      if (token == null && needsAuth) {
        return null;
      }
      var header = needsAuth ? {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      } : {"Content-Type": "application/json"};
      web.Response response = await web.post(uri,
          headers: header,
          body: jsonEncode(body));
      return response.body;
    }catch(e){
      return null;
    }
  }

  Future<GeneralResponse> httpPostGenRes(String url, dynamic body, {needsAuth = true}) async {
    try{
      Uri uri = Uri.parse(url);
      var pref = await SharedPreferences.getInstance();
      var token = pref.getString(emailToken);
      if (token == null && needsAuth) {
        return GeneralResponse.wentWrong();
      }
      var header = needsAuth ? {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      } : {"Content-Type": "application/json"};
      web.Response response = await web.post(uri,
          headers: header,
          body: jsonEncode(body));
      var data = jsonDecode(response.body);
      print(data);
      if(response.statusCode == 400){
        return GeneralResponse(code: 400, message: 'Email Token is invalid');
      }
      else if(response.statusCode == 200){
        return GeneralResponse(code: 200, message: "Success", data: data);
      }
      return GeneralResponse.wentWrong();
    }catch(e){
      return GeneralResponse.wentWrong();
    }
  }
}
