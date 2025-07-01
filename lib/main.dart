import 'package:flutter/material.dart';
import 'package:quarinom/presentation/screens/loginscreen.dart';
import 'package:quarinom/presentation/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) =>  HomeScreen(),  
      },
    );
  }
}
