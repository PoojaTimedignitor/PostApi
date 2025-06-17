import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_endpoints.dart';

class ApiService{

    final dio = Dio();


    Future<Map<String, dynamic>> registerUser(
        String username,
        String name,
        String password,
        String email,
        ) async {
      String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.registerUser}';
      print("🚀 Registering to URL: $url");

      var payload = {
        "username": username,
        "name": name,
        "password": password,
        "email": email,
      };

      try {
        Response response = await dio.post(
          url,
          data: payload,
          options: Options(
            headers: {
              "Content-Type": "application/json",
            },
          ),
        );

        print('Register response : ${response.data}');

        if (response.data['success'] == true) {
          final SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString('user_data', jsonEncode(response.data['user']));

          return {
            'success': true,
            'message': response.data['message'],
            'user': response.data['user']
          };
        } else {
          return {
            'success': false,
            'message': response.data['message'] ?? 'Registration Failed',
          };
        }
      } on DioError catch (e) {
        print('Dio error : ${e.response?.data ?? e.message}');
        return {
          'success': false,
          'message': e.response?.data is Map
              ? e.response?.data['message'] ?? 'Server Error'
              : 'Server Error',
          'error': e.message
        };
      } catch (e) {
        print('Unexpected Error : $e');
        return {
          'success': false,
          'message': "Unexpected Error occurred",
          'error': e.toString()
        };
      }
    }



    Future<Map<String, dynamic>> loginUser(String username, password)async{
     String url = ApiEndPoints.baseUrl + AuthEndPoints().loginUser;
     print("🚀 Loggin to URL: $url");

     var payload = {
       'username' : username,
       'password' : password
     };

     try{
       Response response = await dio.post(
           url,
           data: payload,
         options: Options(
           headers: {
             'Content-type' : 'application/json'
           }
         )
       );

       print('Login response : ${response.data}');
       print(" Status Code: ${response.statusCode}");

       if(response.statusCode == 200 && response.data['success'] == true){
         final SharedPreferences preferences = await SharedPreferences.getInstance();
         await preferences.setString('user_data', jsonEncode(response.data['token']));
         await preferences.setBool('is_logged_in', true);

         print('Login Successful : ${response.data['message']}');
         print('Login Tokennnnn : ${response.data['token']}');
          //return response.data;
         return {
           'success': true,
           'message': response.data['message'],
           'user': response.data['token']
         };
       }else{
         print(" Login Failed: ${response.data['message']}");
         return {
           'success' : false,
           'message' : response.data['message'] ?? 'Login Failed'
         };
       }
     }on DioError catch (e) {
       print('Dio errorrr : ${e.response?.data ?? e.message}');
       return {
         'success': false,
         'message': e.response?.data is Map
             ? e.response?.data['message'] ?? 'Server Error'
             : 'Server Error',
         'error': e.message
       };
     } catch (e) {
       print('Unexpected Error : $e');
       return {
         'success': false,
         'message': "Unexpected Error occurred",
         'error': e.toString()
       };
     }

    }
}


