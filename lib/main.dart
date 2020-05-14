import 'package:flutter/material.dart';

import 'package:flutter_online_store/pages/login_page.dart';
import 'package:flutter_online_store/pages/products_page.dart';

import 'pages/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Store',
      routes: {
        '/login':(BuildContext context) => LoginPage(),
        '/register':(BuildContext context) =>RegisterPage(),
        '/products':(BuildContext context) => ProductsPage()
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Colors.blueGrey[600],
        accentColor: Colors.teal[500],
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 46.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 31.0),
          body1: TextStyle(fontSize: 22.0)
        )
      ),
      //home: MyHomePage(title: 'Flutter'),
      home: RegisterPage()
    );
  }
}

