
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/equipments.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/members.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../Controllers/GymOwnerController/addMemberController.dart';

class AddMemberProvider extends ChangeNotifier{
  AddMemberControllers addMemberControllers=AddMemberControllers();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String? Uid = FirebaseAuth.instance.currentUser?.uid;

  var tempImage;
  var downloadUrl;
  var MemberName;
  var MemberPhoneNumber;
  var MemberFee;
  var MemberPayDate;

  pickImage() async {
    try {
      var photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(photo!=null){
        tempImage = File(photo!.path);
        print("IMage is selected");
        // uploadFile();
      }else{
        print("No image selected");
      }

    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
  }
   Future<void>uploadFile() async {

    if ( tempImage != null) {
      Uuid uuid = Uuid();
      var ImageName = uuid.v4();
      UploadTask uploadTask= FirebaseStorage.instance.ref().child("MemberImages")
          .child(ImageName).putFile(tempImage!);
      TaskSnapshot taskSnapshot=await uploadTask;
      downloadUrl=await taskSnapshot.ref.getDownloadURL();
    }else
    {
      return;
    }
  }

  Future<void> GetMemberControllerValues() async {
    MemberName=addMemberControllers.memberNameController.text;
    MemberPhoneNumber=addMemberControllers.memberPhoneNumberController.text;
    MemberFee=addMemberControllers.memberFeeController.text;
    MemberPayDate=addMemberControllers.memberPayDateController.text;
  }

  ClearControllers(){
    addMemberControllers.memberNameController.clear();
    addMemberControllers.memberPhoneNumberController.clear();
    addMemberControllers.memberFeeController.clear();
    addMemberControllers.memberPayDateController.clear();
    notifyListeners();
  }

  Future <void> WriteDataOfMembersInFirebase(context)async{
    Uuid uuid = Uuid();
    var MemberId=uuid.v4();
    FirebaseFirestore.instance
        .collection("GymMembers")
    // .where("UserUid" , isEqualTo: Uid )
        .doc()
        .set({'MemberName':MemberName,
      'MemberPhoneNumber':MemberPhoneNumber,
      'MemberFee':MemberFee,
      'MemberPayDate':MemberPayDate,
      'MemberId':MemberId,
      'Image':downloadUrl,
      'UserUid':Uid,
    }).then((value){
      print("Update Successfully");
      ClearControllers();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Members()));
    }).catchError((onError){
      print("Faild to update");
      print(onError);
    });
    notifyListeners();
  }

}

