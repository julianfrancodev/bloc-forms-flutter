import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/preferences/preferencias_usuario.dart';
import 'package:bloc_validate_forms/src/routes/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(Provider(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloc Validate',
      initialRoute: '/',
      routes: routes,
    ),
  ));
}
