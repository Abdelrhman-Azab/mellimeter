import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/widgets/orderItemWid.dart';
import 'package:provider/provider.dart';
import '../providers/order.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = "/OrderScreen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading;
  @override
  void initState() {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final _orderData = Provider.of<Orders>(context, listen: false);
      _orderData.loadProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _orderData = Provider.of<Orders>(context, listen: false);
    bool isAuth = FirebaseAuth.instance.currentUser != null;

    print(_orderData.orders.length);

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
          title: Text("طلباتي"),
        ),
        body: !isAuth
            ? Center(
                child: Text("لا يوجد طلبات"),
              )
            : _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        OrderItemWid(_orderData.orders[index]),
                    itemCount: _orderData.orders.length,
                  ));
  }
}
