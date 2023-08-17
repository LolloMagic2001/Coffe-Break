import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home/settings_form.dart';
import 'package:project/services/auth.dart';
import 'package:project/services/database.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';
import 'brewList.dart';

class Home extends StatelessWidget {

  final AuthService _auth= AuthService();

  @override
  Widget build(BuildContext context) {

    void showSettingsPanel(){
      showModalBottomSheet(context: context, builder:(context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    //a ogni change mi arriva una lista di brew
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Brew Crew"),
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.brown[400])
              ),
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            ElevatedButton.icon(
              onPressed: () {
                showSettingsPanel();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.brown[400])
              ),
              icon: Icon(Icons.settings),
              label : Text("Settings"),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/coffee_bg.png"
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()
        ),
      ),
    );
  }
}
