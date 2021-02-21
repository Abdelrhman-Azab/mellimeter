import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mellimeter/screens/adminAddProductScreen.dart';
import 'package:mellimeter/screens/adminEditProductScreen.dart';
import 'package:mellimeter/screens/adminViewOrdersScreen.dart';
import 'package:mellimeter/screens/productsScreen.dart';
import 'package:mellimeter/services/pushNotifications.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = "/admin";

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  void initState() {
    PushNotificationService().subscribeToAdmin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.30,
          ),
          Center(
            child: FlatButton(
                minWidth: 150,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AdminAddProductScreen.routeName);
                },
                child: Text("add product")),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Center(
            child: FlatButton(
                minWidth: 150,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AdminEditProductScreen.routeName);
                },
                child: Text("edit product")),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Center(
            child: FlatButton(
                minWidth: 150,
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AdminViewOrderScreen.routeName);
                },
                child: Text("orders")),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Center(
            child: FlatButton(
                minWidth: 150,
                color: Colors.white,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushReplacementNamed(ProductScreen.routeName);
                },
                child: Text("Sign Out")),
          ),
        ],
      ),
    );
  }
}
