import 'package:ebb/screens/authenticate/authenticate.dart';
import 'package:ebb/screens/main/home.dart';
import 'package:ebb/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null)
      return AuthenticatePage();
    else {
      DatabaseService.uid = user.getUid();
      return HomePage();
    }
  }
}
