import 'package:flutter/material.dart';
import 'package:mellimeter/widgets/adminEditListView.dart';

class AdminEditProductScreen extends StatelessWidget {
  static const routeName = "/admineditproductsscreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Edit Product"),
      ),
      body: AdminEditListView(),
    );
  }
}
