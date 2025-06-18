import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/ProfileAssignModel.dart';
import '../utils/Auth_Storage.dart';
import '../utils/api_endpoints.dart';

class ApiService{

    final dio = Dio();


    // Future<Map<String, dynamic>> registerUser(
    //     String username,
    //     String name,
    //     String password,
    //     String email,
    //     ) async {
    //   String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.registerUser}';
    //   print("🚀 Registering to URL: $url");
    //
    //   var payload = {
    //     "username": username,
    //     "name": name,
    //     "password": password,
    //     "email": email,
    //   };
    //
    //   try {
    //     Response response = await dio.post(
    //       url,
    //       data: payload,
    //       options: Options(
    //         headers: {
    //           "Content-Type": "application/json",
    //         },
    //       ),
    //     );
    //
    //     print('Register response : ${response.data}');
    //
    //     if (response.data['success'] == true) {
    //       final SharedPreferences preferences = await SharedPreferences.getInstance();
    //       await preferences.setString('user_data', jsonEncode(response.data['user']));
    //
    //       return {
    //         'success': true,
    //         'message': response.data['message'],
    //         'user': response.data['user']
    //       };
    //     } else {
    //       return {
    //         'success': false,
    //         'message': response.data['message'] ?? 'Registration Failed',
    //       };
    //     }
    //   } on DioError catch (e) {
    //     print('Dio error : ${e.response?.data ?? e.message}');
    //     return {
    //       'success': false,
    //       'message': e.response?.data is Map
    //           ? e.response?.data['message'] ?? 'Server Error'
    //           : 'Server Error',
    //       'error': e.message
    //     };
    //   } catch (e) {
    //     print('Unexpected Error : $e');
    //     return {
    //       'success': false,
    //       'message': "Unexpected Error occurred",
    //       'error': e.toString()
    //     };
    //   }
    // }


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
          final user = response.data['user'];
          final token = response.data['token'];

          // ✅ Save all user details using GetStorage helper
          await AuthStorage.saveUserDetails(
            userId: user['_id'] ?? '',
            email: user['email'] ?? '',
            username: user['username'] ?? '',
            name: user['name'] ?? '',
            password: payload['password'] as String, // saved only if needed
            token: token ?? '',
          );

          return {
            'success': true,
            'message': response.data['message'],
            'user': user,
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
          'error': e.message,
        };
      } catch (e) {
        print('Unexpected Error : $e');
        return {
          'success': false,
          'message': "Unexpected Error occurred",
          'error': e.toString(),
        };
      }
    }




    // Future<Map<String, dynamic>> loginUser(String username, password)async{
    //  String url = ApiEndPoints.baseUrl + AuthEndPoints().loginUser;
    //  print("🚀 Loggin to URL: $url");
    //
    //  var payload = {
    //    'username' : username,
    //    'password' : password
    //  };
    //
    //  try{
    //    Response response = await dio.post(
    //        url,
    //        data: payload,
    //      options: Options(
    //        headers: {
    //          'Content-type' : 'application/json'
    //        }
    //      )
    //    );
    //
    //    print('Login response : ${response.data}');
    //    print(" Status Code: ${response.statusCode}");
    //
    //    if(response.statusCode == 200 && response.data['success'] == true){
    //      final SharedPreferences preferences = await SharedPreferences.getInstance();
    //      await preferences.setString('user_data', jsonEncode(response.data['token']));
    //      await preferences.setBool('is_logged_in', true);
    //
    //      print('Login Successful : ${response.data['message']}');
    //      print('Login Tokennnnn : ${response.data['token']}');
    //       //return response.data;
    //      return {
    //        'success': true,
    //        'message': response.data['message'],
    //        'user': response.data['token']
    //      };
    //    }else{
    //      print(" Login Failed: ${response.data['message']}");
    //      return {
    //        'success' : false,
    //        'message' : response.data['message'] ?? 'Login Failed'
    //      };
    //    }
    //  }on DioError catch (e) {
    //    print('Dio errorrr : ${e.response?.data ?? e.message}');
    //    return {
    //      'success': false,
    //      'message': e.response?.data is Map
    //          ? e.response?.data['message'] ?? 'Server Error'
    //          : 'Server Error',
    //      'error': e.message
    //    };
    //  } catch (e) {
    //    print('Unexpected Error : $e');
    //    return {
    //      'success': false,
    //      'message': "Unexpected Error occurred",
    //      'error': e.toString()
    //    };
    //  }
    //
    // }


    Future<Map<String, dynamic>> loginUser(String username, String password) async {
      String url = ApiEndPoints.baseUrl + AuthEndPoints().loginUser;
      print("🚀 Logging into URL: $url");

      var payload = {
        'username': username,
        'password': password,
      };

      try {
        Response response = await dio.post(
          url,
          data: payload,
          options: Options(
            headers: {'Content-type': 'application/json'},
          ),
        );

        print('Login response: ${response.data}');
        if (response.statusCode == 200 && response.data['success'] == true) {
          final token = response.data['token'];
          if (token != null) {
            await AuthStorage.setToken(token); // ✅ Use GetStorage
          }

          return {
            'success': true,
            'message': response.data['message'],
            'token': token,
          };
        } else {
          return {
            'success': false,
            'message': response.data['message'] ?? 'Login Failed',
          };
        }
      } on DioError catch (e) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'Server Error',
          'error': e.message,
        };
      } catch (e) {
        return {
          'success': false,
          'message': "Unexpected Error occurred",
          'error': e.toString()
        };
      }
    }



  Future<ProfileAssignModel?> getProfileData() async {
    String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.profile}';
    debugPrint('📡 Profile Data URL: $url');

    try {
      final token = AuthStorage.getToken(); // ✅ Use GetStorage instead of SharedPreferences
      debugPrint('🔑 Stored Access Token: $token');

      if (token == null || token.isEmpty) {
        debugPrint('! Token is null or empty. User might not be logged in.');
        return null;
      }

      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      debugPrint('✅ Profile API Response: ${response.data}');

      if (response.statusCode == 200) {
        return ProfileAssignModel.fromJson(response.data);
      } else {
        debugPrint('❌ Failed to load profile. Status: ${response.statusCode}');
        return null;
      }
    } on DioError catch (e) {
      debugPrint('DioError ❗: ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error ❗: $e');
      return null;
    }
  }

  
  Future<List<String>> getMainCategory()async{
      String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getCategories}';
        print('Main Categories : $url');
        
        try{
          Response response = await dio.get(url);
             if(response.statusCode == 200 && response.data['success'] == true){
                List<dynamic> jsonData =  response.data['data'];

                List<String> categoryNames = jsonData.map((ele) => ele['name'].toString()).toList();
                  print('Category Name : $categoryNames');

                  // orrr
               /*List<Map<String, String>> categories = data.map((item) {
                     return {
                          "id": item["_id"],
                       "name": item["name"]
                      };
                       }).toList();*/
               return categoryNames;
             }else{
               print('Api Error : ${response.data['message']}');
               return [];
             }
        }catch(e){
          print( 'Exception : $e');
          return [];
        }
  }


}


