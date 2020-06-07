import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/models/user.dart';
import 'package:flutter_online_store/redux/actions.dart';
import 'package:flutter_online_store/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class CartPage extends StatefulWidget {
  final void Function() onInit;
  CartPage({this.onInit});

  @override
  CartPageState createState()=> CartPageState();
}

class CartPageState extends State<CartPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void initState(){
    super.initState();
    widget.onInit();
    StripeSource.setPublishableKey("API_KEY");
  }
 

  Widget _cartTab(state){
    final Orientation orientation = MediaQuery.of(context).orientation;
    // return StoreConnector<AppState, AppState>(
          
    //       converter: (store) => store.state,
          
    //       builder: (_, state){
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
        //   }, 
        // );
  }
  Widget _cardsTab(state){
    // return StoreConnector<AppState, AppState>(
          
    //       converter: (store) => store.state,
          
    //       builder: (_, state){
            _addCard(cardToken) async {
              final User user = state.user;
              //update current user's data to include card token
              await http.put('http://10.0.2.2:1337/users/${user.id}', body: {
                "card_token": cardToken
              },
              headers: {
                "Authorization": "Bearer ${user.jwt}"
              });

              http.Response response = await http.post('http://10.0.2.2:1337/card/add', body: {
                "source": cardToken, 
                "customer": user.customerId
              });

              final responseData = json.decode(response.body);
              return responseData;
            }
            return Column(children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 5.0)),
              RaisedButton(
                elevation: 8.0,
                child: Text('Add Payment Card Details'),
                onPressed: () async {
                  final String cardToken = await StripeSource.addSource();
                  final card = await _addCard(cardToken);
                  //action to add card to display
                  StoreProvider.of<AppState>(context).dispatch(AddCardAction(card));
                  //action to update card token
                  StoreProvider.of<AppState>(context).dispatch(UpdateCardTokenAction(card['id']));
                  //snackbar
                  final snackbar = SnackBar(
                    content: Text('Your Payment Card Has Been Added!', style: TextStyle(color: Colors.green))
                    );
                    _scaffoldKey.currentState.showSnackBar(snackbar);
                }),
              Expanded(child: ListView(
                children: state.cards.map<Widget>((c) => (ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                  ),
                  title: Text("${c['card']['exp_month']}/${c['card']['exp_year']}, ${c['card']['last4']}"),
                  subtitle: Text(c['card']['brand']),
                  trailing: state.cardToken == c['id'] ? 
                  Chip(avatar: CircleAvatar(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.check_circle_outline, color: Colors.white)
                  ),
                  label: Text("Selected Card"),
                  ) : FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    child: Text('Set As Primary', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    onPressed: () {
                      StoreProvider.of<AppState>(context).dispatch(UpdateCardTokenAction(c['id']));
                    },
                  )
                ))).toList(),
              ))
            ]);
          // });
  }
  Widget _ordersTab(state){
    return Text('Orders');
  }

  String calculateTotalPrice(cartProducts){
    double totalPrice = 0.0;
    cartProducts.forEach((cartProduct){
      totalPrice += cartProduct.price;
    });
    return totalPrice.toStringAsFixed(2);
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_,state) {
    
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: state.cartProducts.length > 0 ?
        FloatingActionButton(child: Icon(Icons.attach_money, size: 31.0),
        onPressed: () => print('Pressed')): Text(''),
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
            _cartTab(state),
            _cardsTab(state),
            _ordersTab(state)

          ],
        ),
      )
      ); });
  }
}