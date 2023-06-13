import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Controllers/GymOwnerController/addMemberController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class MemberProvider extends ChangeNotifier{
  AddMemberControllers addMemberControllers=AddMemberControllers();
  String? Uid = FirebaseAuth.instance.currentUser?.uid;
  CollectionReference GymMember=FirebaseFirestore.instance.collection("GymMembers");
  GetMembersStream(){
    final Stream<QuerySnapshot> memberStream=FirebaseFirestore.instance.collection("GymMembers").where("UserUid", isEqualTo: Uid).snapshots();
    return memberStream;
  }

  Future<void> DeleteMember(String id){
    return GymMember
        .doc(id)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  CallNumber(num) async{
    var number = num; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}