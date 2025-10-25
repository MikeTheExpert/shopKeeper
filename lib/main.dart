import 'package:flutter/material.dart';
import 'package:shop_keeping/pages/home_page.dart';
import 'package:shop_keeping/pages/upload_product_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'home_page': (context) => MyHomePage(),
        'create_page': (context) => UploadProduct(),

      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home:  MyHomePage(),
    );
  }
}
