import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/routes/routes.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(Provider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Validate',
      initialRoute: '/second',
      routes: routes,
    ),
  ));
}

