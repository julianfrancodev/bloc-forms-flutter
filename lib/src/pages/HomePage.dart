import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                _renderEmailInput(),
                SizedBox(
                  height: 30,
                ),
                _renderPassword(),
                SizedBox(
                  height: 30,
                ),
                _renderButton(),
              ],
            ),
          ),
          Text('Olvido el password?'),
          SizedBox(height: 100,)
        ],
      ),
    );
  }

  Widget _renderEmailInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            icon: Icon(
              Icons.alternate_email,
              color: Colors.deepPurple,
            ),
            hintText: "correo@corre.com",
            labelText: "Correo electronico"),
      ),
    );
  }

  Widget _renderPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            icon: Icon(
              Icons.lock_outline,
              color: Colors.deepPurple,
            ),
            hintText: "Password",
            labelText: "Password"),
      ),
    );
  }

  Widget _renderButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 5,
      color: Colors.deepPurple,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        child: Text(
          'Ingresar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
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
