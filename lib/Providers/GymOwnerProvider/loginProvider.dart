
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Helper/appConfig.dart';
import 'package:fit_plan/Helper/showSnakBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:get/get.dart';
import "package:http/http.dart";
import '../../Controllers/GymOwnerController/loginController.dart';
import '../../Helper/helper.dart';
import '../../Screens/GymOwnerScreens/homePage.dart';

class LoginProvider extends ChangeNotifier{
  LoginController loginController=LoginController();
  var Email;
  var Password;

  GetLoginControllerValues(){
    Email=loginController.emailController.text;
    Password=loginController.passwordController.text;
    notifyListeners();
  }
  ClearControllers(){
    loginController.emailController.clear();
    loginController.passwordController.clear();
    notifyListeners();
  }


  // void login1(context)async{
  //   try{
  //
  //     https.Response  response =await post(Uri.parse('http://127.0.0.1:8000/api/login'),body: {
  //       'email':Email,
  //       'password':Password,
  //     });
  //     if(response.statusCode==200){
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => HomePage()),
  //       );
  //       debugPrint('sucessfully login');
  //     }
  //     else{
  //       debugPrint('incorrect email & password');
  //     }
  //   }
  //   catch(e){
  //     debugPrint(e.toString());
  //
  //   }
  //
  // }


 Future<void> Login(context)async{
    final bool isValid = EmailValidator.validate(Email);
    if(Email == "" && Password == ""){
      showSnackBar(context, "Enter email and password");
    }
   else if(isValid==false){
      // SnackBarPage();
      showSnackBar(context, "please enter correct email");
        }else if (loginController.passwordController.value == null || loginController.passwordController.text.length < 7 ){
       showSnackBar(context, "please enter correct password");
    }else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email:  Email ,
            password: Password,
        ).then((value)  {
        Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomePage(),
        ),
        );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackBar(context, "No user found for that email.");
        }  else if (e.code == 'wrong-password') {
          showSnackBar(context, "Wrong password provided for that user.");
        }else if(FirebaseAuth.instance.currentUser!=null){
          showSnackBar(context, "Logged in successflly");
          print(" ");
        } else if(FirebaseAuth.instance.currentUser==null){
          showSnackBar(context, "Logged in failed");
        }
        notifyListeners();
      }
    }
  }
}
