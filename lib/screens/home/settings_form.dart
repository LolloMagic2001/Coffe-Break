import 'package:flutter/material.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database.dart';
import 'package:project/shared/Loading.dart';
import 'package:project/shared/constant.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0","1","2","3","4"];

  //form values
  String? _currentName ;
  String? _currentSugars;
  int? _currentStrenght ;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserApp?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user?.uid).userData,
      builder: (context, snapshot) {
        print("${snapshot} 2");
        print("${snapshot.hasData}");
        if(snapshot.hasData){

          UserData? userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Update your brew settings.",
                    style: TextStyle(fontSize: 18)
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty ? "Please enter a name" : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _currentSugars ?? userData?.sugar,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    _currentSugars = value!;
                  },
                ),
                SizedBox(height: 20),
                Slider(
                    value: (_currentStrenght ?? userData?.strenght)!.toDouble(),
                    activeColor: Colors.brown[_currentStrenght ?? 100],
                    inactiveColor: Colors.brown[_currentStrenght ?? 100],
                    min: 100,
                    max:900,
                    divisions: 8,
                    onChanged: (val){
                      setState(() {
                        _currentStrenght = val.round();
                      });
                    }
                ),
                //dropDown
                //slider
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink[400]
                    ),
                  ),
                  child: Text(
                    "update",
                    style: TextStyle(color: Colors.white),
                  ),

                  onPressed: () async {
                    //si aggiorna da solo perchè ho uno stream di DatabaseService.brews
                    //in Home così che se qualcosa cambia modifica la schermata
                    if(_formKey.currentState!.validate()){
                      await DatabaseService(uid: user?.uid).updateUserData(
                          _currentSugars ?? userData!.sugar,
                          _currentName ?? userData!.name,
                          _currentStrenght ?? userData!.strenght);
                      //chiude la bottom
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        }else{
          print(" CAZZI IN CULO");
          return Loading();
        }
      }
    );
  }
}
