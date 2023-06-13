import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/appConfig.dart';

class SideMenuProvider extends ChangeNotifier {
    var data;
    String? Uid = FirebaseAuth.instance.currentUser?.uid;
    var profilePicture;

    GetProfieImage() {
        Stream<QuerySnapshot> ProfileStream = FirebaseFirestore.instance
            .collection("GymOwner").where("UserUid" , isEqualTo:  Uid).snapshots();
        return ProfileStream;
    }

    // Future<String> getSpecie(String petId) async {
    //     DocumentReference documentReference = petCollection.document(petId);
    //     String specie;
    //     await documentReference.get().then((snapshot) {
    //         specie = snapshot.data['specie'].toString();
    //     });
    //     return specie;
    // }

}



