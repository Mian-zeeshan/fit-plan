import 'package:fit_plan/Controllers/signupController.dart';
import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/signupProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../Helper/helper.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget  {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode FName;
  late FocusNode FEmial;
  late FocusNode FPassword;
  late FocusNode FGymName;
  late FocusNode FGymLocation;
  late FocusNode FGymCharges;

  @override
  void initState() {

    FName= new FocusNode();
    FEmial= new FocusNode();
    FPassword= new FocusNode();
    FGymName = new FocusNode();
    FGymLocation= new FocusNode();
    FGymCharges= new FocusNode();
    // TODO: implement initState
    super.initState();
  }
  void dispose(){

    FName.dispose();
    FEmial.dispose();
    FPassword.dispose();
    FGymName.dispose();
    FGymLocation.dispose();
    FGymCharges.dispose();

  }
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context,listen: false);
    return Scaffold(

      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:28.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: text("SignUp",size: 26.0,fontWeight: FontWeight.bold)),
                ),
                      Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment:Alignment.topLeft,
                              child: text("   Name",size: 16.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the name',signupProvider.nameController, FName),
                          SizedBox(height: 30,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: text("   Email",size: 16.0,fontWeight: FontWeight.bold,)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the email',signupProvider.emailController,FEmial),
                          SizedBox(height: 30,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: text("   Password",size: 16.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the password',signupProvider.passwordController,FPassword),
                          SizedBox(height: 30,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: text("   GymName",size: 16.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the gym name',signupProvider.gymNameController,FGymName),
                          SizedBox(height: 30,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: text("   GymLocation",size: 16.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the gym location',signupProvider.gymLocationController,FGymLocation),
                          SizedBox(height: 20,),
                          Row(
                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width/4,
                                  height: 45,
                                  color: buttonColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: text("Goole Map Location",size: 16.0,fontWeight: FontWeight.bold),
                                  onPressed: () async {
                                    signupProvider.DeterminePosition();
                                    Position position = await signupProvider.DeterminePosition();
                                    signupProvider.Lat = position.latitude;
                                    signupProvider.Long = position.longitude;
                                    showSnackBar(context, "Location  getted");

                                  }),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Align(
                              alignment:Alignment.topLeft,
                              child: text("   GymCharges",size: 16.0,fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          signUpTextField('Enter the gym charges',signupProvider.gymChargesController,FGymCharges),
                          SizedBox(height: 10,),
                          Row(
                            // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            children: [
                              MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width/4,
                                  height: 45,
                                  color: buttonColor,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  child: text("Profile Image",size: 16.0,fontWeight: FontWeight.bold),
                                  onPressed: (){
                                    signupProvider.pickImage(
                                    );
                                  }),
                              SizedBox(width: 10,),
                              Container(
                                height:80,
                                width:80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: textFieldColor,width: 3)
                                ),
                                child:
                                signupProvider.tempImage==null?Image.network("src"):
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(signupProvider.tempImage,fit: BoxFit.fill,)),

                              )
                            ],
                          ),
                          SizedBox(height: 30,),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 45,
                              color: buttonColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: text("Create Account ",size: 16.0,fontWeight: FontWeight.bold),
                              onPressed: (){
                                 _formKey.currentState!.validate();
                                 signupProvider.GetSignupControllerValues();
                                 signupProvider.SignUp(context,FName,FEmial,FPassword,FGymName,FGymLocation,FGymCharges);

                          }),
                          SizedBox(height: 30,),
                          GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement<void, void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const LoginPage(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text("Already have account? ",size: 16.0,),
                                  text("Login",size: 16.0,fontWeight: FontWeight.bold),
                                ],
                              )),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      )
    );
  }
}
