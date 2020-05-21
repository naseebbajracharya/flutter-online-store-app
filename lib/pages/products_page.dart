//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/redux/actions.dart';
import 'package:flutter_online_store/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:badges/badges.dart';

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
          title: SizedBox(child: state.user != null ? Text(state.user.username) : Text('Online Store Application')),
          leading: state.user != null 
          ? BadgeIconButton(
            itemCount: state.cartProducts.length,
            badgeColor: Colors.redAccent,
            badgeTextColor: Colors.black,
            hideZeroCount: false,
            icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          ) : Text(''),
          actions: [
            Padding(padding: EdgeInsets.only(right: 12.0),
            child: StoreConnector<AppState, VoidCallback>(
              converter: (store) {
               return () => store.dispatch(logoutUserAction);
              },
              builder:(_, callback) {
                return state.user != null ? IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: callback) : Text('');
              }
            )
            )
          ]
        );
      }
    )
  );



  @override
  Widget build(BuildContext context){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _appBar,

      body: Container(
        decoration: gradientBackground,
        
        child: StoreConnector<AppState, AppState>(
          
          converter: (store) => store.state,
          
          builder: (_, state){
            return Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    top:false,
                    bottom: false,
                    child: GridView.builder(
                      itemCount: state.products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0
                      ),
                      itemBuilder:(context, i) =>
                      ProductItem(item: state.products[i]),
                      
                    ),
                  ),
                )
              ],
            );
          }, 
        ),
        
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          icon: Icon(Icons.account_circle),
          label: Text("Sign In"),
          backgroundColor: Colors.green,
        ),
        
    );
  }
  // Widget fab(state) {
  //   if (state.user == null) {
  //     return FloatingActionButton(
  //         backgroundColor: Colors.deepOrange[800],
  //         child: Icon(Icons.add_shopping_cart),
  //         onPressed: null);
  //   }
  // }
}