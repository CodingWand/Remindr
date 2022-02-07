import 'package:ebb/services/auth.dart';
import 'package:ebb/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remindr',
      theme: ThemeData(
        primaryColor: Colors.greenAccent[400],
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamProvider<User>.value(
        value: AuthService().user,
        child: Scaffold(
          body: Wrapper(),
        ),
      ),
    );
  }
}
