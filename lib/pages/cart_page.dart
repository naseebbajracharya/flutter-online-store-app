import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartPage extends StatefulWidget {
  @override
  CartPageState createState()=> CartPageState();
}

class CartPageState extends State<CartPage> {

  Widget _cartTab(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return StoreConnector<AppState, AppState>(
          
          converter: (store) => store.state,
          
          builder: (_, state){
            return Column(
              children: <Widget>[
                Expanded(
                  child: SafeArea(
                    top:false,
                    bottom: false,
                    child: GridView.builder(
                      itemCount: state.cartProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0
                      ),
                      itemBuilder:(context, i) =>
                      ProductItem(item: state.cartProducts[i]),
                      
                    ),
                  ),
                )
              ],
            );
          }, 
        );
  }
  Widget _cardsTab(){
    return Text('Cards');
  }
  Widget _ordersTab(){
    return Text('Orders');
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
          bottom: TabBar(
            labelColor: Colors.grey[100],
            unselectedLabelColor: Colors.grey[400],
            tabs: <Widget>[
              Tab(icon: Icon(Icons.shopping_basket)),
              Tab(icon: Icon(Icons.payment)),
              Tab(icon: Icon(Icons.receipt))
            ],
          )
        ),
        body: TabBarView(
          children: <Widget>[
            _cartTab(),
            _cardsTab(),
            _ordersTab()

          ],
        ),
      )
      );
  }
}