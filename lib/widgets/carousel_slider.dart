import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget carouselSlider(items) => SizedBox(
  height:200,
  child: Carousel(
    boxFit: BoxFit.cover,
    images: [
      //AssetImage('images/ad3.PNG'),
      AssetImage('images/ad1.jpg'),
      AssetImage('images/ad2.jpg')
    ],
    autoplay: true,
    dotSize: 4.0,
    indicatorBgPadding: 8.0,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),

  )
);