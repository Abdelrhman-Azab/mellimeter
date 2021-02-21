import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/order.dart';

class OrderItemWid extends StatefulWidget {
  final OrderItem order;
  OrderItemWid(this.order);

  @override
  _OrderItemWidState createState() => _OrderItemWidState();
}

class _OrderItemWidState extends State<OrderItemWid> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            leading: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                  print(_expanded);
                });
              },
            ),
            trailing: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("المجموع الكلي : ${widget.order.amount.toString()} جنيه"),
                SizedBox(
                  height: 5,
                ),
                Text(
                    DateFormat('yyyy-MM-dd – h:mm a').format(widget.order.date))
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (_expanded)
            Container(
                margin: EdgeInsets.all(10),
                height: widget.order.products.length.toDouble() * 25,
                child: ListView(
                  children: widget.order.products
                      .map((prod) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  " ${prod.price.toString()} x ${prod.quantity.toString()}"),
                              Text(
                                prod.title,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ))
                      .toList(),
                )),
        ],
      ),
    );
  }
}
