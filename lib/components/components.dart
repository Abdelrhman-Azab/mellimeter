import 'package:flutter/material.dart';

Widget adminSelectButton(
    {@required String title,
    @required Function fun,
    @required int radioValue,
    @required int radioGroupValue}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        title,
      ),
      Radio(
        value: radioValue,
        groupValue: radioGroupValue,
        onChanged: (val) {
          fun(val);
        },
      ),
    ],
  );
}

Widget adminTextForm(
    {@required String labelText,
    @required TextInputType keyboardType,
    @required Key key,
    @required String failedText,
    @required onSaveValue}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        key: key,
        keyboardType: keyboardType,
        validator: (value) {
          if (value.length < 15) {
            return failedText;
          }
          return null;
        },
        onSaved: (newValue) {
          onSaveValue = newValue;
        },
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            alignLabelWithHint: true,
            labelText: labelText),
      ),
    ),
  );
}

Widget appDrawerListTile(
    {@required BuildContext context,
    @required String title,
    @required IconData iconData,
    @required Widget screen}) {
  return ListTile(
    title: Text(
      title,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 20, color: Colors.black),
    ),
    trailing: Icon(
      iconData,
      color: Colors.black,
    ),
    onTap: () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => screen));
    },
  );
}
