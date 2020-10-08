import 'package:bloc_validate_forms/src/bloc/provider.dart';
import 'package:bloc_validate_forms/src/providers/user_provider.dart';
import 'package:bloc_validate_forms/src/utils/utils.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final userProvider = new UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            _renderBackground(context),
            _renderLoginForm(context),
          ],
        ));
  }

  Widget _renderLoginForm(BuildContext context) {
    final bloc = Provider.of(context);

    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
                height: 190,
              )),
          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric(vertical: 30),
            margin: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3)
                ]),
            child: Column(
              children: [
                Text(
                  'Ingreso',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 60,
                ),
                _renderEmailInput(bloc),
                SizedBox(
                  height: 30,
                ),
                _renderPassword(bloc),
                SizedBox(
                  height: 30,
                ),
                _renderButton(bloc,context),
              ],
            ),
          ),
          FlatButton(onPressed: ()=> Navigator.pushReplacementNamed(context, '/'), child: Text("Ingresar")),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _renderEmailInput(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                counterText: snapshot.data,
                hintText: "correo@corre.com",
                errorText: snapshot.error,
                labelText: "Correo electronico"),
            onChanged: (value) {
              bloc.changeEmail(value);
            },
          ),
        );
      },
    );
  }

  Widget _renderPassword(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                bloc.changePasword(value);
              },
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.deepPurple,
                  ),
                  errorText: snapshot.error,
                  hintText: "Password",
                  labelText: "Password"),
            ),
          );
        });
  }

  Widget _renderButton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (context, snapshot) {
          return RaisedButton(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 5,
            color: Colors.deepPurple,
            onPressed: snapshot.hasData ? () => _signin(bloc, context) : null,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text(
                'Ingresar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  _signin(LoginBloc bloc, BuildContext context) async{

    Map info = await userProvider.signin(bloc.email, bloc.password);
    if(info['ok']){
      Navigator.pushReplacementNamed(context, '/second');

    }else{
      showAlert(context, "Credenciales Incorrectas");
    }
    // Navigator.pushReplacementNamed(context, '/second');
  }

  Widget _renderBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final purpleBackground = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromRGBO(63, 63, 156, 1),
            Color.fromRGBO(90, 70, 178, 1),
          ])),
    );

    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: [
        purpleBackground,
        Positioned(
          child: circle,
          top: 90,
          left: 30,
        ),
        Positioned(
          child: circle,
          top: -40,
          right: -30,
        ),
        Positioned(
          child: circle,
          bottom: -50,
          right: -10,
        ),
        Positioned(
          child: circle,
          bottom: 120,
          right: 20,
        ),
        Positioned(
          child: circle,
          bottom: -50,
          right: -20,
        ),
        Container(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100,
              ),
              SizedBox(
                height: 10,
                width: double.infinity,
              ),
              Text(
                'Julian Franco',
                style: TextStyle(color: Colors.white, fontSize: 25),
              )
            ],
          ),
        )
      ],
    );
  }
}
