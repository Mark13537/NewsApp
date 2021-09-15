import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, String message,
    Function? okPressed) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog

      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        title: new Text(
          title,
          style: TextStyle(),
        ),
        content: new Text(
          message,
          style: TextStyle(),
        ),
        actions: <Widget>[
          new TextButton(
            child: new Text("OK", style: TextStyle()),
            onPressed: () => okPressed,
          ),
        ],
      );
    },
  );
}
