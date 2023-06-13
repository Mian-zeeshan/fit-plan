import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Models/GymOwnerModel/loginModel.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/loginProvider.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/signupPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Helper/helper.dart';
import 'forgotPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginModel loginModel = LoginModel();
  showExistDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Close App'),
          content: Text('Are you sure you want to close the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return showExistDialog();
      },
      child: Scaffold(
        backgroundColor: background,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child:
                        Align(alignment: Alignment.center, child: text("Login", size: 26.0, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textField(
                            'Enter the email',
                            loginProvider.loginController.emailController,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          textField('Enter the password', loginProvider.loginController.passwordController),
                          SizedBox(
                            height: 30,
                          ),
                          MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              height: 45,
                              color: buttonColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: text("Login", size: 16.0, fontWeight: FontWeight.bold),
                              onPressed: () async {
                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("Login", "Already Login");
                                loginProvider.GetLoginControllerValues();
                                loginProvider.Login(context);
                                _formKey.currentState!.validate();
                                loginProvider.Login(context);
                                loginProvider.ClearControllers();
                                // provider.emailValidation()==true?Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => HomePage()),
                                // ):"";
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement<void, void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) => const SignupPage(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(
                                    "Don't have an account? ",
                                    size: 16.0,
                                  ),
                                  text("Signup", size: 16.0, fontWeight: FontWeight.bold),
                                ],
                              )),
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
