import 'package:deneme/Screens/ContactPage.dart';
import 'package:flutter/material.dart';
import 'Screens/MainPage.dart';
import 'Screens/LoginPage.dart';
import 'Screens/MovieDetailPage.dart';
import 'Screens/RegisterPage.dart';
import 'Screens/ProfilePage.dart';
import 'Screens/StartupPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yemek Tarifleri',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: {
        '/MainPage':(context) => const MainPage(),
        '/LoginPage':(context) => const LoginPage(),
        '/RegisterPage':(context) => const RegisterPage(),
        '/ProfilePage':(context) => const ProfilePage(),
        '/ContactPage':(context) => const ContactPage(),
        '/StartupPage':(context) => const StartupPage(),

      },
      initialRoute:'/StartupPage' ,

    );
  }
}
