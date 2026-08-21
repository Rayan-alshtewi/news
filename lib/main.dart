import 'package:flutter/material.dart';
import 'package:news/ui/news_Screen.dart';
import 'package:news/utils/app_routs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routes:{
        AppRouts.newsScreen:(_)=>NewsScreen(),
      },
      initialRoute:AppRouts.newsScreen,
    );
  }
}

