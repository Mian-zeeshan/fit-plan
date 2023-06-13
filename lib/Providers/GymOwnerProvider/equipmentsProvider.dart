import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class EquipmentsProvider extends ChangeNotifier{
  String? Uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference GymEquipment=FirebaseFirestore.instance.collection("GymEquipments");
    GetEquipmentsStream(){
    final Stream<QuerySnapshot> equipmentStream=FirebaseFirestore.instance.collection("GymEquipments").where("UserUid", isEqualTo: Uid).snapshots();
    return equipmentStream;
  }

  Future<void> DeleteEquipment(String id){
    return GymEquipment
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

}