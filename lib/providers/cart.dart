import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final String id;
  final int price;
  double quantity;
  final String title;
  final String imageUrl;

  CartItem({this.id, this.price, this.quantity, this.title, this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double cartTotal() {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String productId, int price, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (sameCartItem) => CartItem(
              imageUrl: sameCartItem.imageUrl,
              id: sameCartItem.id,
              price: sameCartItem.price,
              title: sameCartItem.title,
              quantity: sameCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              price: price,
              quantity: 1,
              title: title,
              imageUrl: imageUrl));
    }
    print(_items.values.toList()[0].id);
    notifyListeners();
  }

  void deleteItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void plusQuantity(String productId) {
    _items.update(
        productId,
        (sameCartItem) => CartItem(
            imageUrl: sameCartItem.imageUrl,
            id: sameCartItem.id,
            price: sameCartItem.price,
            title: sameCartItem.title,
            quantity: sameCartItem.quantity + 1));
    notifyListeners();
  }

  void minusQuantity(String productId) {
    _items.update(
        productId,
        (sameCartItem) => CartItem(
            imageUrl: sameCartItem.imageUrl,
            id: sameCartItem.id,
            price: sameCartItem.price,
            title: sameCartItem.title,
            quantity: sameCartItem.quantity - 1));
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
