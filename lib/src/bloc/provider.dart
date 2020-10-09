import 'package:bloc_validate_forms/src/bloc/login_bloc.dart';
import 'package:bloc_validate_forms/src/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
export 'package:bloc_validate_forms/src/bloc/login_bloc.dart';
export 'package:bloc_validate_forms/src/bloc/products_bloc.dart';


class Provider extends InheritedWidget {

  static Provider _instance;
  final loginBloc = new LoginBloc();
  final _productsBloc = new ProductsBloc();

  factory Provider({Key key, Widget child}){
    if(_instance == null){
      _instance = new Provider._internal(key: key,child: child,);
    }

    return _instance;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductsBloc productsBloc (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._productsBloc;
  }
}
