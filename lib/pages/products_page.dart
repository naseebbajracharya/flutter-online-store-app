//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
//import 'package:shared_preferences/shared_preferences.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomRight,
    end:Alignment.topLeft,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.teal[100],
      Colors.teal[200],
      Colors.teal[300],
      Colors.teal[400],
      Colors.teal[500]
    ]
  )
);

class ProductsPage extends StatefulWidget {
  final void Function() onInit;
  ProductsPage({ this.onInit });

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage>{
  void initState(){
    super.initState();
    widget.onInit();
    
  }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state){
        return AppBar(
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text(state.user.username) : Text('')),
          leading: Icon(Icons.shopping_cart),
          actions: [
            Padding(padding: EdgeInsets.only(right: 12.0),
            child: state.user != null ? IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: () => print('pressed')) : Text('')
            )
          ]
        );
      }
    )
  );



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _appBar,
      body: Container(
        decoration: gradientBackground,
        child: Column(children: [
          Row(children: [Text('Available Products')])]),
      ),
    );
  }
}