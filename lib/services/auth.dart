import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on FirebaseUser
  UserApp? _userFromFirebaseUser(User? user){
    return user != null ? UserApp(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserApp?> get user{
    return _auth.authStateChanges()./*map((event) => _userFromFirebaseUser(event));*/
      map(_userFromFirebaseUser);
  }

  //sign in anonimous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  //sign in email & pw
  Future signInWithEmailAndPassword(String email, String pw) async{
    try{
      UserCredential result= await _auth.signInWithEmailAndPassword(email: email, password: pw);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email & pw
  Future registerWithEmailAndPassword(String email, String pw) async{
    try{
       UserCredential result= await _auth.createUserWithEmailAndPassword(email: email, password: pw);
       User? user = result.user;

       //create a new document for the user with the uid
       await DatabaseService(uid: user!.uid).updateUserData("0", "new crew membar", 100);
       return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}