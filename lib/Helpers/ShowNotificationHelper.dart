import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, String message,
    Function okPressed) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: new Text(title),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("OK"),
            onPressed: okPressed,
          ),
        ],
      );
    },
  );
}
