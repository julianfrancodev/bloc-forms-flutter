import 'package:flutter/material.dart';

bool isNumber(String value) {
  if (value.isEmpty) return false;

  final n = num.tryParse(value);

  return (n == null) ? false : true;
}

void showAlert(BuildContext context, String message){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Login Failed"),
      content: Text(message),
      actions: [
        FlatButton(onPressed: ()=>Navigator.of(context).pop(), child: Text('ok'))
      ],
    );
  });
}