import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Helper/Constant/globelButton.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  showLogoutDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                await preferences.clear();
                await FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        await FirebaseAuth.instance.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
            ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              bottom: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.7,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 8.0, left: 8.0, right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Expanded(
                      //   child: Text(
                      //     user?.name ?? "Name not found",
                      //     style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 25),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Text(
                      //     user?.roleName ?? "Role not found",
                      //     style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 25),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GlobalButton(
                          title: "Logout",
                          onTap: () {
                            showLogoutDialog(context);
                          },
                          isActive: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipPath(
              clipper: CurveClipper(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: Image.network(
                  // user?.profileImage?.url == '' || user?.profileImage == null || user == null

                  // ?
                  'https://static.vecteezy.com/system/resources/previews/004/991/321/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
                  // : '${StaticInfo.baseUrl}${user.profileImage?.url}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: const Center(
                    child: Icon(Icons.arrow_back),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width - 200, 350);
    Offset endPoint = Offset(size.width, size.height - 50); // first one to handle the left side x axis

    Path path = Path()
      ..lineTo(0, size.height - 50)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
