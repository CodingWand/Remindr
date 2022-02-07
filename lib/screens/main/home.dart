import 'package:ebb/screens/main/add.dart';
import 'package:ebb/screens/main/rem_list.dart';
import 'package:ebb/services/auth.dart';
import 'package:ebb/services/database.dart';
import 'package:flutter/material.dart';
import 'package:ebb/models/rappel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();
  bool _onHomePage = true;

  void _switchToHomePage() {
    setState(() {
      if (!_onHomePage) _onHomePage = true;
    });
  }

  void _switchToListPage() {
    setState(() {
      if (_onHomePage) _onHomePage = false;
    });
  }

  void _navigateToAddPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                AddPage(false, Reminder("", DateTime.now(), 0, 3))));
  }

  BottomAppBar buildBottomNavBar() {
    return BottomAppBar(
      child: Container(
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              color:
                  (_onHomePage) ? Theme.of(context).primaryColor : Colors.black,
              tooltip: "Accueil",
              onPressed: _switchToHomePage,
              icon: Icon(Icons.home),
            ),
            Divider(),
            IconButton(
              color: (!_onHomePage)
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              tooltip: "Rappels",
              onPressed: _switchToListPage,
              icon: Icon(Icons.list),
            ),
          ],
        ),
      ),
      shape: const CircularNotchedRectangle(),
    );
  }

  @override
  Widget build(BuildContext context) {
    BottomAppBar myBotNavBar = buildBottomNavBar();
    return StreamProvider<List<Reminder>>.value(
      value: DatabaseService().reminders,
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          title: (_onHomePage) ? Text("Pour aujourd'hui") : Text("Vos rappels"),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: 'Se déconnecter',
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Déconnexion"),
                          content: Text(
                              "Êtes vous sûr de vouloir vous déconnecter ?"),
                          actions: [
                            TextButton(
                              child: Text("Non"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text("Oui"),
                              onPressed: () async {
                                await auth.signOut();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
              },
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
        body: (_onHomePage) ? HomeRemList() : RemList(),
        floatingActionButton: FloatingActionButton(
          tooltip: "Ajouter une tache",
          onPressed: _navigateToAddPage,
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: myBotNavBar,
      ),
    );
  }
}
