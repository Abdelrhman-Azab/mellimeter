import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin.dart';

class AdminButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Provider.of<Admin>(context).isAdmin
              ? GestureDetector(
                  onTap: () {
                    Provider.of<Admin>(context, listen: false)
                        .changeAdminState(false);
                  },
                  child: Text("حساب مستخدم"))
              : GestureDetector(
                  onTap: () {
                    Provider.of<Admin>(context, listen: false)
                        .changeAdminState(true);
                  },
                  child: Text("حساب ادمن"))
        ],
      ),
    );
  }
}
