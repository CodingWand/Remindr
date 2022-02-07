import 'package:ebb/screens/authenticate/form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthOptions { NONE, SIGN_IN, REGISTER_IN }

class AuthenticatePage extends StatefulWidget {
  @override
  _AuthenticatePageState createState() => _AuthenticatePageState();
}

class _AuthenticatePageState extends State<AuthenticatePage> {
  AuthOptions showSignIn = AuthOptions.NONE;

  void navigateToFormScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPage(
            signingIn: (showSignIn == AuthOptions.SIGN_IN),
          ),
        ));
  }

  void onAuthButtonPressed(AuthOptions selected) {
    setState(() {
      showSignIn = selected;
      navigateToFormScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        color: Colors.black12,
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 100.0),
              ElevatedButton(
                onPressed: () => onAuthButtonPressed(AuthOptions.SIGN_IN),
                child: Text(
                  "Se connecter",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => onAuthButtonPressed(AuthOptions.REGISTER_IN),
                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
if (!choosed && showSignIn == 0) {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          color: Colors.black12,
          child: Center(
            child: ListView(
              children: [
                SizedBox(height: 100.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      choosed = true;
                      showSignIn = 1;
                    });
                  },
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      choosed = true;
                      showSignIn = 2;
                    });
                  },
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return FormPage(showSignIn == 1, comeBackToAuthPage);
    }
 */
