import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news/ui/news_Screen.dart';
import 'package:news/ui/news_Screen_details.dart';
import 'package:news/utils/app_routs.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routes:{
        AppRouts.newsScreen:(_)=>NewsScreen(),
        AppRouts.newsScreenDetails:(_)=>NewsScreenDetails(),
      },
      initialRoute:AppRouts.newsScreen,
    );
  }
}

