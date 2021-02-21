import 'package:flutter/material.dart';
import 'package:mellimeter/providers/cart.dart';

class AdminOrder with ChangeNotifier {
  final String userName;
  final String userAddress;
  final int userNumber;
  final List<CartItem> products;
  final String userId;
  final String orderName;
  final double orderTotal;
  final String orderTime;
  AdminOrder(
      {this.userName,
      this.orderTime,
      this.userAddress,
      this.userNumber,
      this.products,
      this.userId,
      this.orderName,
      this.orderTotal});
}
