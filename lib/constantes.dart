import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

//retourne une couleur
int hexColor(String color) {
  String newColor = '0xff' + color;
  newColor = newColor.replaceAll("#", "");
  int finalColor = int.parse(newColor);
  return finalColor;
}

//Retourne la date dans le format souhaité
String showDate(DateTime date) {
  return DateFormat.yMMMd().format(date);
}

//Retourne le widget de chargement
Widget buildLoading() {
  return Center(
    child: SpinKitRotatingPlain(
      color : Colors.greenAccent[200],
      size: 25.0,
    ),
  );
}

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink),
  ),
);