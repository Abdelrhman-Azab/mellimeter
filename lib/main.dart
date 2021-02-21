import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/providers/admin.dart';
import 'package:mellimeter/providers/product.dart';
import 'package:mellimeter/screens/adminAddProductScreen.dart';
import 'package:mellimeter/screens/adminEditProductScreen.dart';
import 'package:mellimeter/screens/adminScreen.dart';
import 'package:mellimeter/screens/adminViewOrdersScreen.dart';
import 'package:mellimeter/screens/cartScreen.dart';
import 'package:mellimeter/screens/newloginscreen.dart';
import 'package:mellimeter/services/auth.dart';
import 'package:mellimeter/services/pushNotifications.dart';
import 'package:provider/provider.dart';
import './screens/productsScreen.dart';
import './providers/cart.dart';
import 'screens/prodDetailsScreen.dart';
import './screens/orderScreen.dart';
import './providers/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService().getDeviceToken();
  await PushNotificationService().initialise();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Product(),
        ),
        ChangeNotifierProvider(
          create: (context) => Admin(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.black),
        debugShowCheckedModeBanner: false,
        home: FBAuth().checkIfAdminAuth() ? AdminScreen() : ProductScreen(""),
        routes: {
          ProductScreen.routeName: (ctx) => ProductScreen(""),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProdDetailsScreen.routeName: (ctx) => ProdDetailsScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          NewLoginScreen.routeName: (ctx) => NewLoginScreen(),
          AdminScreen.routeName: (ctx) => AdminScreen(),
          AdminAddProductScreen.routeName: (ctx) => AdminAddProductScreen(),
          AdminViewOrderScreen.routeName: (ctx) => AdminViewOrderScreen(),
          AdminEditProductScreen.routeName: (ctx) => AdminEditProductScreen(),
        },
      ),
    );
  }
}
