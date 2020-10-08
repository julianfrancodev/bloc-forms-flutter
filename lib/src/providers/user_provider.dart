import 'dart:convert';

import 'package:bloc_validate_forms/src/preferences/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UserProvider{

  final String _firebaseToken = 'AIzaSyCx_bjJ-DLvGbe0oOeHYIBiJ9RFwc9A8YQ';
  final _prefs = new PreferenciasUsuario();




  Future<Map<String, dynamic>> signin(String email, String password)async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseToken',
        body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      return {'ok':true, 'token':decodedResp['idToken']};
    }else{
      return {'ok':false, 'token':decodedResp['error']['message']};
    }
  }

  Future<Map<String, dynamic>> createUser(String email, String password) async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if(decodedResp.containsKey('idToken')){
      _prefs.token = decodedResp['idToken'];
      return {'ok':true, 'token':decodedResp['idToken']};
    }else{
      return {'ok':false, 'token':decodedResp['error']['message']};
    }
  }


}