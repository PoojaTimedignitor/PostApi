import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/CreateAllCatModel.dart';
import '../Model/GetProductIdModel.dart';
import '../Model/ProfileAssignModel.dart';
import '../Model/SubCatModel.dart';
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
      print(" Registering to URL: $url");

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
    debugPrint(' Profile Data URL: $url');

    try {
      final token = AuthStorage.getToken();
      debugPrint(' Stored Access Token: $token');

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

      debugPrint(' Profile API Response: ${response.data}');

      if (response.statusCode == 200) {
        return ProfileAssignModel.fromJson(response.data);
      } else {
        debugPrint(' Failed to load profile. Status: ${response.statusCode}');
        return null;
      }
    } on DioError catch (e) {
      debugPrint('DioError : ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      debugPrint('Unexpected Error : $e');
      return null;
    }
  }


  //////////////// without id
  // Future<List<String>> getMainCategory()async{
  //     String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getCategories}';
  //       print('Main Categories : $url');
  //
  //       try{
  //         Response response = await dio.get(url);
  //            if(response.statusCode == 200 && response.data['success'] == true){
  //               List<dynamic> jsonData =  response.data['data'];
  //
  //               List<String> categoryNames = jsonData.map((ele) => ele['name'].toString()).toList();
  //                 print('Category Name : $categoryNames');
  //
  //              return categoryNames;
  //            }else{
  //              print('Api Error : ${response.data['message']}');
  //              return [];
  //            }
  //       }catch(e){
  //         print( 'Exception : $e');
  //         return [];
  //       }
  // }

/////////////////////// with id

    Future<List<Map<String, dynamic>>> getMainCategory() async {
      String url = '${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getCategories}';
      print('Main Categories : $url');

      try {
        Response response = await dio.get(url);
        if (response.statusCode == 200 && response.data['success'] == true) {
          List<dynamic> jsonData = response.data['data'];

          List<Map<String, String>> categories = jsonData.map((item) {
            return {
              "id": item["_id"].toString(),
              "name": item["name"].toString(),
            };
          }).toList();

          print('Category Name : $categories');
          return categories;
        } else {
          print('Api Error : ${response.data['message']}');
          return [];
        }
      } catch (e) {
        print('Exception : $e');
        return [];
      }
    }



  Future<String?> getCategoryIdByName(String categoryName) async {
    try {
      List<Map<String, dynamic>> categories = await getMainCategory();

      if (categories.isNotEmpty) {
        for (var category in categories) {
          if (category['name'].toString().toLowerCase() == categoryName.toLowerCase()) {
            return category['_id'];
          }
        }
      } else {
        print("⚠ No categories found.");
      }
    } catch (e) {
      print(" Error fetching category ID: $e");
    }
    return null;
  }



  // Future<Map<String, dynamic>?> NewGetAllSubCat(String categoryId) async {
  //   if (!RegExp(r"^[0-9a-fA-F]{24}$").hasMatch(categoryId)) {
  //     print(" Category ID is a name, fetching ObjectId...");
  //     categoryId = await getCategoryIdByName(categoryId) ?? categoryId;
  //   }
  //
  //   String url = "${ApiEndPoints.baseUrl}/${ApiEndPoints.authEndPoints.getCategories}/$categoryId/${ApiEndPoints.authEndPoints.getSubCategories}";
  //   print("🌐 API URL: $url");
  //
  //   final token = AuthStorage.getToken();
  //   debugPrint(' Stored Access Token: $token');
  //
  //   if (token == null || token.isEmpty) {
  //     debugPrint('! Token is null or empty. User might not be logged in.');
  //     return null;
  //   }
  //
  //   try {
  //     Response response = await dio.get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //
  //     print(" Response Status Code: ${response.statusCode}");
  //     print(" Raw Response Data: ${response.data}");
  //
  //     return response.data;
  //   } on DioError catch (e) {
  //     print(" Dio Error: ${e.response}");
  //     return e.response?.data ?? {};
  //   }
  // }

///////////////////////////////////////////////////


//////////////////////////// good
/*
  Future<SubCatModel?> NewGetAllSubCat(String categoryId) async {
    if (!RegExp(r"^[0-9a-fA-F]{24}$").hasMatch(categoryId)) {
      print(" Category ID is a name, fetching ObjectId...");
      categoryId = await getCategoryIdByName(categoryId) ?? categoryId;
    }

    String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.gettSubCategories}";
    print(" API URL: $url");

    final token = AuthStorage.getToken();
    debugPrint(' Stored Access Token: $token');

    if (token == null || token.isEmpty) {
      debugPrint('! Token is null or empty. User might not be logged in.');
      return null;
    }

    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print(" Response Status Code: ${response.statusCode}");
      print(" Raw Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        return SubCatModel.fromJson(response.data);
      } else {
        print(" Failed to fetch subcategories: ${response.statusMessage}");
        return null;
      }
    } on DioError catch (e) {
      print("Dio Error: ${e.response}");
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }
*/



  Future<SubCatModel?> NewGetAllSubCat(String categoryId) async {
    if (!RegExp(r"^[0-9a-fA-F]{24}$").hasMatch(categoryId)) {
      print("Category ID is a name, fetching ObjectId...");
      categoryId = await getCategoryIdByName(categoryId) ?? categoryId;
    }

    String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.gettSubCategories}";
    print('Product Apiii : $url');
    final token = AuthStorage.getToken();

    if (token == null || token.isEmpty) {
      return null;
    }

    try {
      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return SubCatModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }



//////////////////////// post api create


  // Future<CreateAllCatModel?> createProduct({
  //   required String title,
  //   required String description,
  //   required double price,
  //   required String subCategoryId,
  //  // required String subSubCategoryId,
  // }) async {
  //   String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.PostCreateData}";
  //   print('Create Post: $url');
  //   final token = AuthStorage.getToken();
  //
  //   if (token == null || token.isEmpty) {
  //     print('Token is missing');
  //     return null;
  //   }
  //
  //   try {
  //     Response response = await dio.post(
  //       url,
  //       data: {
  //         'title': title,
  //         'description': description,
  //         'price': price,
  //         'subCategory': subCategoryId,
  //        // 'subSubCategory': subSubCategoryId,
  //       },
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 201 && response.data != null) {
  //       return CreateAllCatModel.fromJson(response.data);
  //     } else {
  //       print('Create product failed: ${response.statusCode}, ${response.data}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error while creating product: $e');
  //     return null;
  //   }
  // }

  Future<CreateAllCatModel?> createProduct({
    required String title,
    required String description,
    required double price,
    required String subCategoryId,
  }) async {
    String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.PostCreateData}";
    print('Create Post: $url');
    final token = AuthStorage.getToken();

    if (token == null || token.isEmpty) {
      print('Token is missing');
      return null;
    }

    try {
      Response response = await dio.post(
        url,
        data: {
          'title': title,
          'description': description,
          'price': price,
         // 'category': '68273b23dfdf9d509bb3349b', // TODO: make dynamic later
          'subCategory': subCategoryId,
          //'owner': '6840164a5875b708bed21ade',   // TODO: make dynamic later
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print(' Response data: ${response.data}');

      if (response.statusCode == 201 && response.data != null) {
        return CreateAllCatModel.fromJson(response.data);
      } else {
        print(' Create product failed: ${response.statusCode}, ${response.data}');
        return null;
      }
    } catch (e) {
      if (e is DioException) {
        print(' DioException data: ${e.response?.data}');
      }
      print('Error while creating product: $e');
      return null;
    }
  }


  // Future<GetProductIdModel?> getProductById(String productId) async {
  //   final String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getProductId}$productId";
  //
  //   print('Get Product It : $url');
  //
  //   final String? token = AuthStorage.getToken();
  //
  //   if (token == null || token.isEmpty) {
  //     print('Token is missing');
  //     return null;
  //   }
  //
  //   try {
  //     final response = await Dio().get(
  //       url,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200 && response.data != null) {
  //       return GetProductIdModel.fromJson(response.data);
  //     } else {
  //       print('Failed to fetch product: ${response.statusCode} | ${response.data}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error fetching product: $e');
  //     return null;
  //   }
  // }


  Future<GetProductIdModel?> getProductById(String productId) async {
    final String url = "${ApiEndPoints.baseUrl}${ApiEndPoints.authEndPoints.getProductId}$productId";

    print('Get Product Api url : $url');

    final String? token = AuthStorage.getToken();

    if (token == null || token.isEmpty) {
      print('Token is missing');
      return null;
    }

    try {
      final response = await Dio().get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Raw response data: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          if (data['success'] == false) {
            print("API says failed: ${data['message']}");
            return null;
          }

          return GetProductIdModel.fromJson(data);
        } else {
          print('Unexpected format. Expected Map, got: ${data.runtimeType}');
          return null;
        }
      } else {
        print('Failed to fetch product: ${response.statusCode} | ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }


}


