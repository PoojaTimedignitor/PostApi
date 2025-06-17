

 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post_api_assignment/Screens/Home/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Auth/Login_Screen.dart';
import 'Screens/Auth/Register_screen.dart';

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   final bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
   //runApp(MyApp());
   runApp(MyApp(isLoggedIn: isLoggedIn));

 }



 class MyApp extends StatelessWidget {
   final bool isLoggedIn;

  // const MyApp({super.key});
   const MyApp({super.key, required this.isLoggedIn});


   @override
   Widget build(BuildContext context) {
     return  MaterialApp(
       debugShowCheckedModeBanner: false,
       home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      // home: RegisterScreen(),
     );
   }
 }
