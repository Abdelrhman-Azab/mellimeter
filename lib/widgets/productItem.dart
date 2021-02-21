import 'package:flutter/material.dart';
import '../screens/prodDetailsScreen.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final List imageUrl;
  final String title;
  final int price;
  final String description;
  final String category;
  ProductItem(this.id, this.imageUrl, this.title, this.price, this.description,
      this.category);

  @override
  Widget build(BuildContext context) {
    final _cartData = Provider.of<Cart>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) =>
                ProdDetailsScreen(id, price, title, imageUrl[0], category),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 210,
        child: Card(
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5, bottom: 5, left: 12),
                      width: screenWidth * 0.45,
                      height: 55,
                      child: Text(
                        title,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Text(
                      "السعر : ${price.toString()} جنيه",
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    FlatButton(
                        color: Colors.green[400],
                        onPressed: () async {
                          _cartData.addItem(id, price, title, imageUrl[0]);
                        },
                        child: Text(
                          "إضافه الي عربة التسوق",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: double.infinity,
                  width: screenWidth * 0.48,
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      imageUrl[0],
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
