import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/providers/cart.dart';
import 'package:mellimeter/widgets/decorationProducts.dart';
import 'package:mellimeter/widgets/furnitureProducts.dart';
import 'package:mellimeter/widgets/toolsProducts.dart';
import 'package:provider/provider.dart';
import '../widgets/productGrid.dart';
import '../screens/cartScreen.dart';
import '../widgets/appDrawer.dart';

class ProductScreen extends StatelessWidget {
  static const routeName = "/ProductScreen()";
  final String mycategory;
  ProductScreen(this.mycategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Stack(children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
            Positioned(
              right: 11,
              child: Consumer<Cart>(builder: (context, value, child) {
                if (value.items.length < 1) {
                  return Text("");
                }
                return CircleAvatar(
                  child: Text(value.items.length.toString()),
                  radius: 10,
                  backgroundColor: Colors.red,
                );
              }),
            ),
          ]),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("المتجر"),
        ),
        endDrawer: AppDrawer(),
        body: mycategory == "decoration"
            ? DecorationProducts()
            : mycategory == "furniture"
                ? FurnitureProducts()
                : mycategory == "tools"
                    ? ToolsProducts()
                    : ProductGrid());
  }
}
