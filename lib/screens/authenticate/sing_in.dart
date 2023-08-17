import 'package:flutter/material.dart';
import 'package:project/services/auth.dart';
import 'package:project/shared/Loading.dart';
import 'package:project/shared/constant.dart';


class SignIn extends StatefulWidget {

  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
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
        title: Text("Sign in to Brew Crew"),
        actions: [
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.brown[400])
            ),
            icon: Icon(Icons.person),
            label: Text("register"),
            onPressed: () {
              print("showSignIn");
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
                  decoration:textInputDecoration.copyWith(hintText: "Email"),
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
                child: Text("Sign-in", style: TextStyle(color: Colors.white)),
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, pw);
                      if(result == null){
                        setState(() {
                          loading = false;
                          errore = " Could not sign in with those credentials";
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
