import 'package:bloc_validate_forms/src/pages/HomePage.dart';
import 'package:bloc_validate_forms/src/pages/SecondPage.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => HomePage(),
  '/second': (context) => SecondPage()
};
