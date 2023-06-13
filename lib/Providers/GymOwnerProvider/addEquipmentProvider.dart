
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/equipments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../Controllers/GymOwnerController/addEquipmentsController.dart';

class AddEquipmentProvider extends ChangeNotifier{
  AddEquipmentsControllers addEquipmentsControllers=AddEquipmentsControllers();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String? Uid = FirebaseAuth.instance.currentUser?.uid;

  var tempImage;
  var downloadUrl;
  var EquipmentName;
  var EquipmentDate;
  var EquipmentAmount;
  var EquipmentDetails;
  var result;

  Future pickImage() async {
    try {
      var photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(photo!=null){
        tempImage = File(photo!.path);
        // var temp = tempImage.lastIndexOf('/');
        // // print(temp);
        // result = tempImage.substring(temp + 1);
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
  Future <void>uploadFile() async {
    Uuid uuid = Uuid();
    var ImageName = uuid.v4();

    if ( tempImage != null) {
      UploadTask uploadTask= FirebaseStorage.instance.ref().child("EquipmentsImages")
          .child(ImageName).putFile(tempImage!);
           TaskSnapshot taskSnapshot=await uploadTask;
           downloadUrl=await taskSnapshot.ref.getDownloadURL();
    }else
      {
        return;
      }
  }

  Future<void>GetAddEquipmentsControllerValues()async{
    EquipmentName=addEquipmentsControllers.equipmentNameController.text;
    EquipmentDate=addEquipmentsControllers.equipmentDateController.text;
    EquipmentAmount=addEquipmentsControllers.equipmentAmountController.text;
    EquipmentDetails=addEquipmentsControllers.equipmentDetailsController.text;
    // notifyListeners();
  }

  ClearControllers(){
    addEquipmentsControllers.equipmentNameController.clear();
    addEquipmentsControllers.equipmentDateController.clear();
    addEquipmentsControllers.equipmentAmountController.clear();
    addEquipmentsControllers.equipmentDetailsController.clear();
    notifyListeners();
  }

  Future <void> WriteDataOfEquipmentsInFirebase(context)async{
    FirebaseFirestore.instance
        .collection("GymEquipments")
        // .where("UserUid" , isEqualTo: Uid )
        .doc()
        .set({'EquipmentName':EquipmentName,
      'Date':EquipmentDate,
      'Amount':EquipmentAmount,
      'Details':EquipmentDetails,
      'Image':downloadUrl,
      'UserUid':Uid,
    }).then((value){
      print("Update Successfully");
      ClearControllers();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Equipments()));
    }).catchError((onError){
      print("Faild to update");
      print(onError);
    });
    notifyListeners();
  }



}

