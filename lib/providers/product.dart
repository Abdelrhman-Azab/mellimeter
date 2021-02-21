import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String title;
  final String descreption;
  final int price;
  final List imageurl;
  final String category;
  final String id;
  Product(
      {this.title,
      this.descreption,
      this.price,
      this.id,
      this.category,
      this.imageurl});
}
