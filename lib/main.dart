import 'package:flutter/material.dart';

import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/redux/actions.dart';
import 'package:flutter_online_store/redux/reducers.dart';
import 'package:flutter_online_store/pages/login_page.dart';
import 'package:flutter_online_store/pages/products_page.dart';
import 'package:flutter_online_store/pages/register_page.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  final store = Store<AppState>(appReducer, initialState: AppState.initial(), middleware: [thunkMiddleware]);
  runApp(MyApp(store: store));
} 

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({ this.store });
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return StoreProvider (
      store: store,
      child: MaterialApp(
      title: 'Online Store',
      routes: {
        '/login':(BuildContext context) => LoginPage(),
        '/register':(BuildContext context) =>RegisterPage(),
        '/products':(BuildContext context) => ProductsPage(
          onInit: (){
            StoreProvider.of<AppState>(context).dispatch(getUserAction);
            //dispatch an action (getUserAction) to grab user data
          }
        )
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
    ));
  }
}

