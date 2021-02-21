import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/screens/newloginscreen.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/order.dart';
import 'package:flutter/services.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "/CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isloading;
  @override
  void initState() {
    isloading = false;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    Size size = MediaQuery.of(context).size;
    final _cartData = Provider.of<Cart>(context, listen: false);
    var _cartItems = _cartData.items.values.toList();
    final _orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
        centerTitle: true,
        title: const Text("عربة التسوق"),
      ),
      body: Column(
        children: [
          Container(
            height: size.height -
                AppBar().preferredSize.height -
                size.height * 0.2 -
                padding.top,
            child: ListView.builder(
              itemCount: _cartData.items.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: _cartData.items.values.toList()[index],
                child: Container(
                  height: 180,
                  width: double.infinity,
                  child: Card(
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 150,
                          child: Image.network(
                            _cartItems[index].imageUrl,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                _cartItems[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${_cartItems[index].quantity.toString()} : الكميه",
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${(_cartItems[index].quantity * _cartItems[index].price).toString()} : السعر",
                                textAlign: TextAlign.end,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          _cartData.plusQuantity(_cartData
                                              .items.keys
                                              .toList()[index]);
                                        });
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _cartData.deleteItem(_cartData
                                              .items.keys
                                              .toList()[index]);
                                        });
                                      }),
                                  IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: _cartItems[index].quantity == 1
                                          ? null
                                          : () {
                                              setState(() {
                                                _cartData.minusQuantity(
                                                    _cartData.items.keys
                                                        .toList()[index]);
                                              });
                                            }),
                                  SizedBox(
                                    width: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.2,
            child: Card(
                color: Colors.green[200],
                elevation: 10,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "المجموع الكلي : ${_cartData.cartTotal().toString()} جنيه",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(10),
                      height: 50,
                      minWidth: double.infinity,
                      color: Colors.green[800],
                      onPressed: _cartItems.length == 0
                          ? null
                          : () async {
                              if (FirebaseAuth.instance.currentUser == null) {
                                Navigator.of(context)
                                    .pushNamed(NewLoginScreen.routeName);
                              } else {
                                setState(() {
                                  isloading = true;
                                });
                                await _orderData.addOrder(
                                    _cartItems, _cartData.cartTotal());
                                setState(() {
                                  isloading = false;
                                });
                                _cartData.clearCart();
                              }
                            },
                      child: isloading
                          ? Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white))
                          : Text(
                              "متابعة عملية الشراء",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
