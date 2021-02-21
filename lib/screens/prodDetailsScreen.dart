import 'package:flutter/material.dart';
import 'package:mellimeter/widgets/prodDetails.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

class ProdDetailsScreen extends StatelessWidget {
  static const routeName = "/ProductDetailsScreen";
  final String prodId;
  final String title;
  final int price;
  final String imageurl;
  final String category;
  ProdDetailsScreen(
      [this.prodId, this.price, this.title, this.imageurl, this.category]);

  @override
  Widget build(BuildContext context) {
    final _cartData = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: FlatButton(
              color: Colors.green[400],
              onPressed: () {
                _cartData.addItem(prodId, price, title, imageurl);
              },
              child: Text(
                "إضافه الي عربة التسوق",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("تفاصيل المنتج"),
      ),
      body: ProdDetails(prodId, category),
    );
  }
}
