import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "أهلا بيك في ملليمتر",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(
          width: 10,
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("images/meli.png"),
        ),
        SizedBox(
          width: 30,
        )
      ],
    );
  }
}
