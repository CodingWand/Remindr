import 'package:ebb/models/rappel.dart';
import 'package:ebb/screens/main/add.dart';
import 'package:ebb/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constantes.dart';
import 'check.dart';

Card fromRappelToCard(BuildContext context, Reminder R,
    {bool home = false, Function onTapFunc}) {
  String name = R.name;
  String date = showDate(R.nextRem);
  int mId = R.remID;
  var binColor = Colors.red;
  return Card(
    color: R.isPast() ? Colors.red[100] : Colors.white,
    child: ListTile(
        onTap: () {
          if (!home && onTapFunc != null) {
            onTapFunc(R);
          }
        },
        leading: IconButton(
            onPressed: () {
              if (!home) {
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text("Supprimer"),
                          content: Text(
                              "Êtes vous sûr de vouloir supprimer définitivement le rappel \"${R.name}\" ?"),
                          actions: [
                            TextButton(
                              child: Text("Non"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: Text("Oui"),
                              onPressed: () {
                                DatabaseService().deleteDocument(R.docRef);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ));
              } else {
                onTapFunc(R);
              }
            },
            color: (!home) ? binColor : Colors.green,
            icon: (!home) ? Icon(Icons.delete) : Icon(Icons.check)),
        title: Text('$name'),
        subtitle: Text('date du rappel n°${mId + 1} : $date')),
  );
}

class RemList extends StatefulWidget {
  @override
  _RemListState createState() => _RemListState();
}

class HomeRemList extends StatefulWidget {
  @override
  _HomeRemListState createState() => _HomeRemListState();
}

class _HomeRemListState extends State<HomeRemList> {
  @override
  Widget build(BuildContext context) {
    final rems = Provider.of<List<Reminder>>(context) ?? [];

    void showValidationPanel(final Reminder rem) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 100,
              color: Colors.black,
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Text(
                    'Avez-vous réussi votre rappel ?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  CheckPage(rem),
                ],
              ),
            );
          });
    }

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: (rems.length == 0)
          ? Center(
              child: Text("Ajoutez un rappel pour commencer."),
            )
          : ListView.builder(
              itemCount: rems.length,
              itemBuilder: (context, index) {
                if (rems[index].remindToday(DateTime.now()))
                  return fromRappelToCard(context, rems[index],
                      home: true, onTapFunc: showValidationPanel);
                else
                  return Container(width: 0, height: 0);
              }),
    );
  }
}

class _RemListState extends State<RemList> {
  @override
  Widget build(BuildContext context) {
    final rems = Provider.of<List<Reminder>>(context) ?? [];

    void showSettingsPanel(final Reminder rem) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return AddPage(true, rem);
          });
    }

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 8),
      child: (rems.length == 0)
          ? Center(
              child: Text("Ajoutez un rappel pour commencer."),
            )
          : ListView.builder(
              itemCount: rems.length,
              itemBuilder: (context, index) {
                Card card = fromRappelToCard(context, rems[index],
                    onTapFunc: showSettingsPanel);
                return card;
              }),
    );
  }
}
