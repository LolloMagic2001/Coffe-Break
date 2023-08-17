import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:project/main.dart";
import "package:project/shared/Loading.dart";
import "package:project/shared/constant.dart";

import "../../services/auth.dart";

class Register extends StatefulWidget {

  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String pw = "";
  String errore="";

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up to Brew Crew"),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.brown[400])
            ),
            icon: Icon(Icons.person),
            label: Text("sign-in"),
            onPressed: () {
              print("showSignIn2");
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val!.length<6 ? "Enter a pw 6+ long" : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => pw = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink[400])
                ),
                child: Text("Register", style: TextStyle(color: Colors.white)),
                onPressed: ()async{
                  //se i due form sono corretti allora si fa l'if
                  if(_formKey.currentState!.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, pw);
                      if(result == null){
                        setState(() {
                          loading = false;
                          errore = "please supply a valid email";
                        });
                      }
                  }
                },
              ),
              SizedBox(height: 20),
              Text(errore, style: TextStyle(color : Colors.red,fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}
