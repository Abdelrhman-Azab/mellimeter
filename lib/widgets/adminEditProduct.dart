import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/screens/adminAddProductScreen.dart';

class AdminEditProduct extends StatelessWidget {
  final String _id;
  final List _imageUrl;
  final String _title;
  final int _price;
  final String _description;
  final String _category;
  AdminEditProduct(this._id, this._imageUrl, this._title, this._price,
      this._description, this._category);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: 100,
                    child: Image.network(
                      _imageUrl[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(child: Text(_title)),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminAddProductScreen(
                                1,
                                _id,
                                _title,
                                _price,
                                _description,
                                _category,
                                _imageUrl)),
                      );
                    },
                    child: Text("edit"),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("products")
                          .doc(_id)
                          .delete();
                    },
                    child: Text(
                      "delete",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
