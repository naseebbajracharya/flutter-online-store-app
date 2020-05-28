import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CartPage extends StatefulWidget {
  final void Function() onInit;
  CartPage({this.onInit});

  @override
  CartPageState createState()=> CartPageState();
}

class CartPageState extends State<CartPage> {
  void initState(){
    super.initState();
    widget.onInit();
  }

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
    return StoreConnector<AppState, AppState>(
          
          converter: (store) => store.state,
          
          builder: (_, state){
            return Column(children: <Widget>[
              Expanded(child: ListView(
                children: state.cards.map<Widget>((card) => (ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                  ),
                  title: Text("${card['exp_month']}/${card['exp_year']}, ${card['last4']}"),
                  subtitle: Text(card['brand']),
                  trailing: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Text('Set As Primary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    onPressed: () => print('pressed'),
                  )
                ))).toList(),
              ))
            ]);
          });
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