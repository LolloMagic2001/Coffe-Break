import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/screens/authenticate/authenticate.dart';
import 'package:project/screens/authenticate/sing_in.dart';
import 'package:project/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //ogni volta che ricevo un dato vado a salvarlo qua dentro
    final user = Provider.of<UserApp?>(context);

    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
