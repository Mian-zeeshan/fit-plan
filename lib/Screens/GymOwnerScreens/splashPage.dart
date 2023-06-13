import 'package:fit_plan/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homePage.dart';
import 'loginPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var SharedPreferenceValue;

  @override
  void initState() {
    Timmer();
    getSharedPrefrance();
    // TODO: implement initState
    super.initState();
  }

  Timmer() {
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SharedPreferenceValue == null ? LoginPage() : LandingPage()),
            ));
  }

  getSharedPrefrance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferenceValue = sharedPreferences.getString("Login");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // height: MediaQuery.of(context).size.height / 3,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(fit: BoxFit.fill, "assets/FitplanFinalImage.png"),
        ),
      ),
    );
  }
}
