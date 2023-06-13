import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_plan/Controllers/signupController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../Helper/helper.dart';
import '../../Screens/GymOwnerScreens/loginPage.dart';

class SignupProvider extends ChangeNotifier with SignupController {
  FirebaseFirestore fireStoreDataBase = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  var Email;
  var Password;
  var Name;
  var GymName;
  var GymLocation;
  var GymCharges;
  var Uid;
  var tempImage;
  var downloadUrl;
  var Lat;
  var Long;

  GetSignupControllerValues() {
    Email = emailController.text;
    Password = passwordController.text;
    Name = nameController.text;
    GymName = gymNameController.text;
    GymLocation = gymLocationController.text;
    GymCharges = gymChargesController.text;
    notifyListeners();
  }

  ClearControllers() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    gymNameController.clear();
    gymLocationController.clear();
    gymChargesController.clear();
    notifyListeners();
  }

  Future<void> WriteDataOfGymOnwnerInFirebase(user) async {
    Uuid uuid = Uuid();
    var GymOwnerId = uuid.v4();
    FirebaseFirestore.instance
        .collection("GymOwner")
        // if you want to same uid and document id
        .doc(user.uid)
        .set({
      'GymName': GymName,
      'GymLocation': GymLocation,
      'GymCharges': GymCharges,
      'UserUid': user.uid,
      'GymOwnerId': GymOwnerId,
      'ProfileImage': downloadUrl,
      'UserName': Name,
      'Lat': Lat,
      'Long': Long,
    }).then((value) => {print("Write Data Successfully in Firebase")});
  }

  AuthenticateUser(context, FocusNode fname, FocusNode femail, FocusNode fpassword, FocusNode fgymname,
      FocusNode fgymlocation, FocusNode fgymcharges) {
    final bool isValid = EmailValidator.validate(Email);
    if (nameController.text.isEmpty) {
      showSnackBar(context, "please enter the name");
      fname.requestFocus();
    } else if (!isValid) {
      showSnackBar(context, "please enter correct email");
      femail.requestFocus();
    } else if (passwordController.text.isEmpty) {
      showSnackBar(context, "please enter the password");
      fpassword.requestFocus();
    } else if (gymNameController.text.isEmpty) {
      showSnackBar(context, "please enter the Gym Name");
      fgymname.requestFocus();
    } else if (gymLocationController.text.isEmpty) {
      showSnackBar(context, "please enter the Location");
      fgymlocation.requestFocus();
    } else if (gymChargesController.text.isEmpty) {
      showSnackBar(context, "Enter the Charges");
      fgymcharges.requestFocus();
    }
  }

  Future<void> SignUp(context, FocusNode fname, FocusNode femail, FocusNode fpassword, FocusNode fgymname,
      FocusNode fgymlocation, FocusNode fgymcharges) async {
    final bool isValid = EmailValidator.validate(Email);
    AuthenticateUser(context, fname, femail, fpassword, fgymname, fgymlocation, fgymcharges);
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        isValid == true &&
        passwordController.text.length >= 7 &&
        gymNameController.text.isNotEmpty &&
        gymChargesController.text.isNotEmpty &&
        gymLocationController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: Email,
          password: Password,
        )
            .then((value) {
          if (gymNameController.text.isNotEmpty &&
              gymLocationController.text.isNotEmpty &&
              gymChargesController.text.isNotEmpty) {
            uploadFile().then((val) => {
                  WriteDataOfGymOnwnerInFirebase(value.user).then((value) => {
                        showSnackBar(context, "Account created successfully"),
                        ClearControllers(),
                        Navigator.pushReplacement<void, void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const LoginPage(),
                          ),
                        ),
                      }),
                });
          } else {
            showSnackBar(context, "Complete the form");
          }
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, "The account already exists for that email.");
        }
      } catch (e) {
        print(e);
      }
      notifyListeners();
    }
  }

  pickImage() async {
    try {
      var photo = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (photo != null) {
        tempImage = File(photo!.path);
        print("IMage is selected");
      } else {
        print("No image selected");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    notifyListeners();
  }

  Future uploadFile() async {
    if (tempImage != null) {
      Uuid uuid = Uuid();
      var ProfileImage = uuid.v4();

      UploadTask uploadTask =
          FirebaseStorage.instance.ref().child("ProfilePictures").child(ProfileImage).putFile(tempImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();
    } else {
      return;
    }
  }

  Future<Position> DeterminePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
