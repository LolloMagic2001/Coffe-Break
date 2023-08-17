import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/models/brew.dart';

import '../models/user.dart';

class DatabaseService{

  final String? uid;

  DatabaseService({this.uid});
  //collection reference, se non esiste la crea se no prende il reference
  final CollectionReference brewCollection =  FirebaseFirestore.instance.collection("Brews");

  Future updateUserData(String sugars, String name, int strenght) async{
    //se non esiste la crea se no prende il reference
    return await brewCollection.doc(uid).set({
      "sugars": sugars,
      "name": name,
      "strenght":strenght,
    });
  }

  //brewList form snapshots
  List<Brew>? _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((e) {
      return Brew(name: e.get("name") ?? " ", sugars: e.get("sugars") ?? "0", strenght: e.get("strenght") ?? 0);
    }).toList();
  }

  // get brew strea,
   Stream<List<Brew>?> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    print(" CAAAAAAAAAAAAAAAAA ${uid} + ${snapshot.get("name")}");
    return UserData(id: uid, name: snapshot.get("name"), sugar: snapshot.get("sugars"), strenght: snapshot.get("strenght"));
  }
}