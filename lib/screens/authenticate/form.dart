import 'package:ebb/constantes.dart';
import 'package:ebb/services/auth.dart';
import 'package:flutter/material.dart';

/*
Handles the sign in and register in forms.
 */
class FormPage extends StatefulWidget {
  final bool signingIn;

  FormPage({@required this.signingIn});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email, password, error = "";
  bool signingIn, loading = false;

  @override
  void initState() {
    super.initState();
    signingIn = widget.signingIn;
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 70.0),
            Text(
              error,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: "Email"),
              onChanged: (val) {
                setState(() => {email = val});
              },
              validator: (val) {
                if (val.isEmpty) return "Veuillez renseigner une adresse email";
                return null;
              },
            ),
            SizedBox(height: 10.0),
            TextFormField(
              obscureText: true,
              decoration:
                  textInputDecoration.copyWith(hintText: "Mot de passe"),
              onChanged: (val) {
                setState(() => {password = val});
              },
              validator: (val) {
                if (val.length < 6)
                  return "Entrez un mot de passe d'au moins 6 caractères.";
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: (signingIn) ? Text("Se connecter") : Text("S'inscrire"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result = (signingIn)
                      ? await auth.signInWithEmailPassword(email, password)
                      : await auth.registerWithEmailPassword(email, password);
                  if (result == null) {
                    /* L'authentification a échoué */
                    setState(() {
                      loading = false;
                      error =
                          "ERREUR : vérifiez vos identiifants ou votre connexion Internet.";
                    });
                  }
                }
              },
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              child: Text("Retour"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: loading ? buildLoading() : _buildForm(),
    );
  }
}
