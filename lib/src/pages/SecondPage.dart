import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      body: Center(
        child: Text("Email: ${bloc.email}"),
      ),
    );
  }
}
