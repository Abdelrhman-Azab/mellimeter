import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/providers/adminOrder.dart';
import 'package:mellimeter/providers/cart.dart';
import 'package:mellimeter/screens/adminOrderDetails.dart';

class AdminViewOrderScreen extends StatefulWidget {
  static const routeName = "/adminvieworderscreen";

  @override
  _AdminViewOrderScreenState createState() => _AdminViewOrderScreenState();
}

class _AdminViewOrderScreenState extends State<AdminViewOrderScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Orders"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("orders").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                List<AdminOrder> orders = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                  for (int x = 0;
                      x < snapshot.data.documents[i]["length"];
                      x++) {
                    List<CartItem> mycart = [];
                    for (int z = 0;
                        z <
                            snapshot.data.documents[i]["Order"][x]["Product"]
                                .length;
                        z++) {
                      mycart.add(CartItem(
                          id: snapshot.data.documents[i]["Order"][x]["Product"]
                              [z]["Product id"],
                          imageUrl: snapshot.data.documents[i]["Order"][x]
                              ["Product"][z]["Product imageurl"],
                          price: snapshot.data.documents[i]["Order"][x]
                              ["Product"][z]["Product price"],
                          quantity: snapshot
                              .data
                              .documents[i]["Order"][x]["Product"][z]
                                  ["Product quantity"]
                              .toDouble(),
                          title: snapshot.data.documents[i]["Order"][x]
                              ["Product"][z]["Product name"]));
                    }
                    orders.add(AdminOrder(
                        orderTime: snapshot.data.documents[i]["Order"][x]
                            ["Time"],
                        orderTotal: snapshot
                            .data.documents[i]["Order"][x]["Total"]
                            .toDouble(),
                        orderName: "${x + 1}",
                        userId: snapshot.data.documents[i].id,
                        userName: snapshot.data.documents[i]["Order"][x]
                            ["Username"],
                        userAddress: snapshot.data.documents[i]["Order"][x]
                            ["UserAddress"],
                        userNumber: snapshot.data.documents[i]["Order"][x]
                            ["UserNumber"],
                        products: mycart));
                  }
                }
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 240,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "  Name : " + orders[index].userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "  Address : " + orders[index].userAddress,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "  Mobile number : " +
                                  orders[index].userNumber.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "  Order total : " +
                                  orders[index].orderTotal.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FlatButton(
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AdminOrderDetails(
                                                  orders[index].products),
                                        ));
                                  },
                                  child: Text("View"),
                                  height: 50,
                                  minWidth: size.width * 0.45,
                                ),
                                FlatButton(
                                  color: Colors.red,
                                  onPressed: () async {
                                    var orderTime = orders[index].orderTime;
                                    var x = await FirebaseFirestore.instance
                                        .collection("orders")
                                        .doc(orders[index].userId)
                                        .get();
                                    List<dynamic> selectedProduct =
                                        await x.data()["Order"];

                                    List<dynamic> deletedProduct =
                                        selectedProduct
                                            .where((element) => element
                                                .containsValue(orderTime))
                                            .toList();
                                    print(deletedProduct);
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (x.data()["length"] == 1) {
                                      await FirebaseFirestore.instance
                                          .collection("orders")
                                          .doc(orders[index].userId)
                                          .delete();
                                    } else {
                                      await FirebaseFirestore.instance
                                          .collection("orders")
                                          .doc(orders[index].userId)
                                          .update({
                                        "length": FieldValue.increment(-1),
                                        "Order": FieldValue.arrayRemove(
                                            deletedProduct)
                                      });
                                    }

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Text("Delete"),
                                  height: 50,
                                  minWidth: size.width * 0.45,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
