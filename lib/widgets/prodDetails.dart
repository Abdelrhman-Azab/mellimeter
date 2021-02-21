import 'dart:ui';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/screens/imagevieewscreen.dart';

class ProdDetails extends StatelessWidget {
  final String prodId;
  final String category;
  ProdDetails(this.prodId, this.category);

  @override
  Widget build(BuildContext context) {
    print(category);
    CollectionReference products =
        FirebaseFirestore.instance.collection("products");
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<DocumentSnapshot>(
      future: products.doc(prodId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.5,
                  child: Carousel(
                    autoplay: false,
                    indicatorBgPadding: 1.0,
                    dotIncreasedColor: Colors.black54,
                    dotSize: 6,
                    images: data["imageurl"].map<Widget>(
                      (imageurl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Hero(
                              tag: data["id"],
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => ImageVieewScreen(
                                          imageurl, data["id"]),
                                    ),
                                  );
                                },
                                child: Image.network(
                                  imageurl,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  data["title"],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.90,
                  child: Text(
                    data["descreption"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        }
        return null;
      },
    );
  }
}
