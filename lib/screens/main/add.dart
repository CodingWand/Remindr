import 'package:ebb/services/database.dart';
import 'package:flutter/material.dart';

import 'package:ebb/constantes.dart';
import 'package:ebb/models/rappel.dart';

class AddPage extends StatefulWidget {
  final Reminder rappel;
  final bool modify;
  AddPage(this.modify, this.rappel);

  @override
  _AddPageState createState() => _AddPageState(rappel, modify);
}

class _AddPageState extends State<AddPage> {
  Reminder rem;
  bool modify;
  _AddPageState(this.rem, this.modify);

  final _formKey = GlobalKey<FormState>();

  final reminders = [3, 4, 5, 6, 7];
  final year = 365;

  Container _buildForm() {
    DateTime _nextRem = rem.nextRem;
    String formattedDate = showDate(_nextRem);
    return Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 30.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Nom"),
                initialValue: (rem.name.length != 0) ? rem.name : "",
                onChanged: (val) {
                  setState(() {
                    rem.name = val;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) return "Veuiller nommer votre rappel";
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Text("Nombre de rappels :"),
              SizedBox(height: 2.0),
              DropdownButtonFormField(
                value: rem.maxRem,
                decoration: textInputDecoration,
                onChanged: (val) {
                  setState(() {
                    rem.maxRem = val;
                  });
                },
                items: reminders.map((reminder) {
                  return DropdownMenuItem(
                    value: reminder,
                    child: Text('$reminder rappels'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.0),
              Text("Date du premier rappel :"),
              SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$formattedDate"),
                  IconButton(
                    tooltip: "Modifier la date",
                    icon: Icon(Icons.calendar_today),
                    color: Colors.black,
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(Duration(days: 3 * year)))
                          .then((date) {
                        setState(() {
                          if (date != null) rem.nextRem = date;
                        });
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.yellowAccent, onPrimary: Colors.black),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    try {
                      if (!modify)
                        DatabaseService().add(rem);
                      else
                        DatabaseService().updateReminder(rem);
                    } catch (err) {
                      print(err.toString());
                    }

                    Navigator.pop(context);
                  }
                },
                child: !modify ? Text('Ajouter') : Text("Enregistrer"),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildForm(),
    );
  }
}
