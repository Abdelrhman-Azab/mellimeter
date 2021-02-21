import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/providers/product.dart';
import 'package:mellimeter/widgets/adminEditProduct.dart';

class AdminEditListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        List<Product> products = [];
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          var data = snapshot.data.documents[i];
          products.add(Product(
              id: data["id"],
              category: data["category"],
              imageurl: data["imageurl"],
              price: data["price"],
              title: data["title"],
              descreption: data["descreption"]));
        }
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return AdminEditProduct(
                products[index].id,
                products[index].imageurl,
                products[index].title,
                products[index].price,
                products[index].descreption,
                products[index].category);
          },
        );
      },
    );
  }
}
