import 'package:flutter/material.dart';
import 'package:mellimeter/providers/cart.dart';

class AdminOrderDetails extends StatelessWidget {
  static const routeName = "/AdminOrderDetails";
  final List<CartItem> cart;
  AdminOrderDetails(this.cart);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order details"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          height: 400,
          child: Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Product Title : " + cart[index].title),
              SizedBox(
                height: 20,
              ),
              Text("Product Quantity : " + cart[index].quantity.toString()),
              SizedBox(
                height: 20,
              ),
              Text("Product Price : " + cart[index].price.toString()),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.network(
                    cart[index].imageUrl,
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: 10,
              ),
            ],
          )),
        ),
        itemCount: cart.length,
      ),
    );
  }
}
