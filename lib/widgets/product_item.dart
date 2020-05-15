import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/app_state.dart';
import 'package:flutter_online_store/models/product.dart';
import 'package:flutter_online_store/pages/product_detail_page.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  ProductItem({this.item});

  @override
  Widget build(BuildContext context){
    final String pictureUrl = 'http://10.0.2.2:1337${item.picture['url']}';
    return InkWell (
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ProductDetailPage(item: item);
          }
        )
      ),
      child: GridTile(
      footer: GridTileBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(item.name, style: TextStyle(fontSize: 20.0))
        ),
        subtitle: Text("\Rs.${item.price}", style: TextStyle(fontSize: 15.0)),
        backgroundColor: Color(0xBB000000),
        trailing: StoreConnector<AppState, AppState>(
          converter:(store) => store.state,
          builder: (_, state){
            return state.user != null ? IconButton(icon: Icon(Icons.add_shopping_cart), 
            color: Colors.white, onPressed: () => print('pressed')) : Text('');
          },
        ),
      ),
      child: Hero(tag: item, child: Image.network(pictureUrl, fit: BoxFit.cover),
      )));
  }
}