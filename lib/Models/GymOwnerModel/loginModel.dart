import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fit_plan/Helper/appConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';

import '../../Helper/generalResponse.dart';
import '../../Helper/helper.dart';
import '../../Helper/restConnectors.dart';
import '../../Screens/GymOwnerScreens/homePage.dart';

class LoginModel {


   LoginModel();

   var id;
   var name;
   var email;
   var password;

   LoginModel.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     name = json['name'];
     email = json['email'];
     password = json['password'];
   }

   Future  login () async {
     Map data = {
       'email':  AppConfig.Email,
       'password': AppConfig.Password,
     };

     final jsonData;
     https.Response response = await https.post(Uri.parse(AppConfig.baseUrl+ AppConfig.loginEndPoint), body: data);

     if (response.statusCode == 200) {
       jsonData = jsonDecode(response.body);
       if (jsonData["response"]["status"] == 200) {
         List jsonResponse = jsonData["response"];
         return jsonResponse.map((data) => LoginModel.fromJson(data)).toList();
       } else {
         print('Error 1');
         return [];
       }
     } else {
       print('Error 2');
       throw Exception('Unexpected error occurred!');
     }
   }


    Future <void> GetLoginControllerValues() async {
     email=loginController.emailController.text;
     password=loginController.passwordController.text;
   }



   // Future<dynamic> getHomeApiData(context, endPoint, {leagueId = "", teamId = ""}) async {
   //   String url = endPoint;
   //   Map data = {
   //     "league_id" : leagueId,
   //     "team_id" : teamId,
   //   };
   //
   //   try {
   //     //Response response = await Dio().get(url);
   //     Response? response = await RestConnector(url: url, requestType: "POST", formData: data).getData(context);
   //     return GeneralResponseModel.fromJson(response!.data);
   //   } catch (e) {
   //
   //     return null;
   //   }
   // }


}