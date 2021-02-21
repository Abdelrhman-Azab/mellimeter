import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mellimeter/components/components.dart';
import 'package:mellimeter/providers/admin.dart';
import 'package:mellimeter/screens/newloginscreen.dart';
import 'package:provider/provider.dart';
import '../screens/productsScreen.dart';
import '../screens/cartScreen.dart';
import '../screens/orderScreen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool auth = Provider.of<Admin>(context).checkIfAuth();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
            child: Text(
              "ملليمتر",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              "المتجر",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: Icon(
              Icons.shopping_bag,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductScreen.routeName);
            },
          ),
          appDrawerListTile(
              context: context,
              title: "الديكور",
              iconData: Icons.celebration,
              screen: ProductScreen("decoration")),
          appDrawerListTile(
              context: context,
              title: "الاثاث",
              iconData: Icons.king_bed,
              screen: ProductScreen("furniture")),
          appDrawerListTile(
              context: context,
              title: "الأدوات",
              iconData: Icons.build,
              screen: ProductScreen("tools")),
          ListTile(
            title: Text(
              "عربة التسوق",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: Icon(Icons.shopping_cart, color: Colors.black),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
          ListTile(
            title: Text(
              "طلباتي",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            trailing: Icon(Icons.shopping_bag_rounded, color: Colors.black),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrderScreen.routeName);
            },
          ),
          auth
              ? ListTile(
                  title: Text(
                    "تسجيل الخروج",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pop();
                  },
                )
              : ListTile(
                  title: Text(
                    "تسجيل الدخول",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(NewLoginScreen.routeName);
                  },
                )
        ],
      ),
    );
  }
}
