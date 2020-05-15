import 'package:flutter/material.dart';
import 'package:flutter_online_store/models/product.dart';
import 'package:flutter_online_store/pages/products_page.dart';


class ProductDetailPage extends StatelessWidget {
  final Product item;
  ProductDetailPage({ this.item });

  @override

  Widget build(BuildContext context) {
    final String pictureUrl = 'http://10.0.2.2:1337${item.picture['url']}';
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name)
      ),
      body: Container(
        decoration: gradientBackground,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Hero(tag: item, child: Image.network(pictureUrl,
            width: orientation == Orientation.portrait ? 600 : 250,
            height: orientation == Orientation.portrait ? 400 : 200,
            fit: BoxFit.cover)),
          ),
          Text(item.name, style: Theme.of(context).textTheme.title),
          Text('\Rs.${item.price}', style: Theme.of(context).textTheme.body1),
          Flexible(child: SingleChildScrollView(child: Padding(
            child: Text(item.description),
            padding: EdgeInsets.only(left: 23.0, right: 23.0, bottom: 25.0 ))))
        ]),
        )
    );
  }
}