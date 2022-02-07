import 'package:ebb/models/rappel.dart';
import 'package:flutter/material.dart';
import 'package:ebb/services/database.dart';

//Widget de validation d'un rappel lorsqu'il est effectué
class CheckPage extends StatefulWidget {
  final Reminder rem;
  CheckPage(this.rem);

  @override
  _CheckPageState createState() => _CheckPageState(rem);
}

class _CheckPageState extends State<CheckPage> {
  Reminder rem;
  _CheckPageState(this.rem);

  void handleReminder(BuildContext context) {
    if (rem.toNextReminder()) {
      DatabaseService().updateReminder(rem);
    } else {
      DatabaseService().deleteDocument(rem.docRef);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.thumb_down),
            tooltip: 'Rappel raté',
            onPressed: () {
              setState(() {
                rem.succeed = false;
                handleReminder(context);
              });
            },
          ),
          IconButton(
            color: Colors.green,
            icon: Icon(Icons.thumb_up),
            tooltip: 'Rappel réussi',
            onPressed: () {
              setState(() {
                rem.succeed = true;
                handleReminder(context);
              });
            },
          )
        ],
      ),
    );
  }
}
