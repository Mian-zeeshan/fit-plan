import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  String? Uid = FirebaseAuth.instance.currentUser?.uid;
   GetNameStream(){
    final Stream<QuerySnapshot> nameStream=FirebaseFirestore.instance.collection("GymDatabase").where("UserUid" ,isEqualTo: Uid).snapshots();
    return nameStream;
  }
}