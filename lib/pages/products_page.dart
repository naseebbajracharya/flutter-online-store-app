//import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/redux/actions.dart';
import 'package:flutter_online_store/services/slider_serv.dart';
import 'package:flutter_online_store/widgets/carousel_slider.dart';
import 'package:flutter_online_store/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_online_store/models/product.dart';
import 'package:badges/badges.dart';

final gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomRight,
    end:Alignment.topLeft,
    stops: [0.1, 0.3, 0.5, 0.7, 0.9],
    colors: [
      Colors.grey[50],
      Colors.grey[100],
      Colors.grey[200],
      Colors.grey[300],
      Colors.grey[400]
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
  
  SliderServ _sliderServ = SliderServ();

  var items = [];

  void initState(){
    super.initState();
    widget.onInit();
    // _getAllSliders();
    
  }

  // _getAllSliders() async {
    
  //   //final String pictureUrl = 'http://10.0.2.2:1337${items.picture['url']}';
    
  //   var sliders = await _sliderServ.getSliders();
  //   var result = json.decode(sliders.body);
  //   result['data'].forEach((data){
  //     setState(() {
  //       items.add(NetworkImage(data('picture')));
  //     });
  //   });
    
  //   //print(result);
  // }

  final _appBar = PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    
    child: StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state){
        return AppBar(
          elevation: 1.0,
          centerTitle: true,
          title: SizedBox(child: state.user != null ? Text('Online Store') : Text('Online Store Application')),
          
          //leading: state.user != null 
          // ? BadgeIconButton(
          //   itemCount: state.cartProducts.length,
          //   badgeColor: Colors.redAccent,
          //   badgeTextColor: Colors.white,
          //   hideZeroCount: false,
          //   icon: Icon(Icons.shopping_cart),
          // onPressed: () => Navigator.pushNamed(context, '/cart'),
          // ) : Text(''),
          actions: [
            // Padding(padding: EdgeInsets.only(right: 12.0),
            // child: StoreConnector<AppState, VoidCallback>(
            //   converter: (store) {
            //    return () => store.dispatch(logoutUserAction);
            //   },
            //   builder:(_, callback) {
            //     return state.user != null ? IconButton(icon: Icon(Icons.exit_to_app),
            // onPressed: callback) : Text('');
            //   }
            // ),
            // ),
              Padding(padding: EdgeInsets.only(right: 12.0),
              child: state.user != null?
                BadgeIconButton(
                itemCount: state.cartProducts.length,
                badgeColor: Colors.redAccent,
                badgeTextColor: Colors.white,
                hideZeroCount: false,
                icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              ) : Text(''),
                              )],
        );     
        } 
    ),
    
  );



  @override
  Widget build(BuildContext context){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state){
    
    return Scaffold(
      appBar: _appBar,

      floatingActionButton: state.user == null ?
       FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, '/login'),
          icon: Icon(Icons.account_circle),
          label: Text("Sign In"),
          backgroundColor: Colors.green,
        ) : FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/profile'),
           child: Icon(Icons.supervised_user_circle)),


           drawer: state.user == null ? new Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: Text('PLEASE LOGIN'),
                    accountEmail: Text('OR REGISTER TO CONTINUE'),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.apps, color: Colors.white)
                    ),
                    ),
                  ),

                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/about'),
                    child: ListTile(
                    title: Text('About App'),
                    leading: Icon(Icons.help_outline)
                  )
                  ),
                
                    InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/login'),
                    child: ListTile(
                    title: Text('Sign In'),
                    leading: Icon(Icons.account_circle)
                  )
                  ),

                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/register'),
                    child: ListTile(
                    title: Text('Sign Up'),
                    leading: Icon(Icons.person_add)
                  )
                  ),
                ]
              ))
              :new Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: Text('User: ${state.user.username}'),
                    accountEmail: Text('Email: ${state.user.email}'),
                  currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Icon(Icons.person, color: Colors.white)
                    ),
                    ),
                  ),
                  InkWell(
                    onTap: (){},
                    child: ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home)
                  )
                  ),

                  InkWell(
                    onTap: ()=> Navigator.pushNamed(context, '/cart'),
                    child: ListTile(
                    title: Text('My Carts'),
                    leading: Icon(Icons.shopping_basket, color: Colors.green),
                  )
                  ),

                   InkWell(
                    onTap: (){},
                    child: ListTile(
                    title: Text('About App'),
                    leading: Icon(Icons.help_outline, color: Colors.blueAccent)
                  )
                  ),

                  InkWell(
                    
                    child: StoreConnector<AppState, VoidCallback>(
                      converter: (store) {
                      return () => store.dispatch(logoutUserAction);
                      },
                      builder:(_, callback) {
                        return state.user != null ? ListTile(
                          onTap: (callback),
                    title: Text('Logout'),
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    
                  ) : Text('');
                      }
                    ),
                  )
                  
                ]
              )),
          // backgroundColor: Colors.green),

      body: Container(
        decoration: gradientBackground,
        
        child: StoreConnector<AppState, AppState>(
          
          converter: (store) => store.state,
          
          builder: (_, state){
            
            return Column(
              children: <Widget>[
                carouselSlider(items),

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
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () => Navigator.pushNamed(context, '/login'),
      //     icon: Icon(Icons.account_circle),
      //     label: Text("Sign In"),
      //     backgroundColor: Colors.green,
      //   ),
        
    );
    });
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