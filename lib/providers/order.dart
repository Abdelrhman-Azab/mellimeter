import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final DateTime date;
  final double amount;
  final List<CartItem> products;

  OrderItem(this.id, this.date, this.products, this.amount);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future loadProducts() async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    _orders.clear();
    var orderData =
        await FirebaseFirestore.instance.collection("orders").doc(userId).get();
    if (orderData.data() == null) {
      return;
    } else {
      for (int i = 0; i < orderData.data()["Order"].length; i++) {
        List<CartItem> _cart = [];
        for (int x = 0;
            x < await orderData.data()["Order"][i]["Product"].length;
            x++) {
          String myid =
              await orderData.data()["Order"][i]["Product"][x]["Product id"];
          int myprice =
              await orderData.data()["Order"][i]["Product"][x]["Product price"];
          String myimageurl = await orderData.data()["Order"][i]["Product"][x]
              ["Product imageurl"];
          double myquantity = await orderData.data()["Order"][i]["Product"][x]
              ["Product quantity"];
          String mytitle =
              await orderData.data()["Order"][i]["Product"][x]["Product name"];
          _cart.add(CartItem(
              id: myid,
              price: myprice,
              imageUrl: myimageurl,
              quantity: myquantity,
              title: mytitle));
        }
        _orders.add(OrderItem(
            await orderData.data()["Order"][i]["Time"],
            DateTime.parse(await orderData.data()["Order"][i]["Time"]),
            _cart,
            await orderData.data()["Order"][i]["Total"]));
      }
    }
    notifyListeners();
  }

  Future addOrder(List<CartItem> cartProducts, double total) async {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var time = DateTime.now();
    _orders.insert(
      0,
      OrderItem(time.toString(), time, cartProducts, total),
    );
    var orderData =
        await FirebaseFirestore.instance.collection("orders").doc(userId).get();

    if (orderData.data() == null) {
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      await FirebaseFirestore.instance.collection("orders").doc(userId).set({
        "Order": [
          {
            "Product": cartProducts
                .map((e) => {
                      "Product name": e.title,
                      "Product price": e.price,
                      "Product quantity": e.quantity,
                      "Product imageurl": e.imageUrl,
                      "Product id": e.id
                    })
                .toList(),
            "Total": total,
            "Time": time.toIso8601String(),
            "Username": user.data()["name"],
            "UserAddress": user.data()["address"],
            "UserNumber": user.data()["number"],
            "Completed": "No"
          },
        ],
        "length": 1
      });
    } else {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc("x")
          .set({"no": "no"});
      await FirebaseFirestore.instance.collection("orders").doc("x").delete();
      var user = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .get();
      await FirebaseFirestore.instance.collection("orders").doc(userId).update({
        "Order": FieldValue.arrayUnion([
          {
            "Product": cartProducts
                .map((e) => {
                      "Product name": e.title,
                      "Product price": e.price,
                      "Product quantity": e.quantity,
                      "Product imageurl": e.imageUrl,
                      "Product id": e.id
                    })
                .toList(),
            "Total": total,
            "Time": time.toIso8601String(),
            "Username": user.data()["name"],
            "UserAddress": user.data()["address"],
            "UserNumber": user.data()["number"],
            "Completed": "No"
          },
        ]),
        "length": FieldValue.increment(1)
      });
    }

    notifyListeners();
  }
}
