import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Helper/Constant/dpView.dart';
import 'package:fit_plan/Helper/appConfig.dart';
import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/homePageProvider.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/memberProvider.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/equipments.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/members.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/viewExpenses.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/viewIncome.dart';
import 'package:fit_plan/Screens/profileScreen.dart';
import 'package:fit_plan/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../Helper/helper.dart';
import '../../side_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int membersCount = 0;

  getMembersCount() {
    String? Uid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference GymMember = FirebaseFirestore.instance.collection("GymMembers");
    FirebaseFirestore.instance
        .collection("GymMembers")
        .where("UserUid", isEqualTo: Uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      membersCount = querySnapshot.size;
    });
  }

  @override
  void initState() {
    getMembersCount();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: background,
        title: text("Dashboard", size: 20.0, fontWeight: FontWeight.bold),
        // centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()));
              },
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Container(
              child: DpView(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: ChangeNotifierProvider<HomePageProvider>(
        create: (context) => HomePageProvider(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: background,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            40,
                          ),
                          bottomRight: Radius.circular(
                            40,
                          ),
                        )),
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => ViewIncome()));
                                    },
                                    child: customHomePageCard("Income", "Rs 13,500,00", "assets/income.webp"))
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => ViewExpenses()));
                                    },
                                    child: customHomePageCard("Expense", "Rs 4,500,00", "assets/expense.webp"))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Members()));
                          },
                          child: customHomePageCard("Members", "${membersCount}", "assets/members.webp")),
                      customHomePageCard("Trainers", "5", "assets/trainer.webp")
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Equipments()));
                          },
                          child: customHomePageCard("Equipments", "12", "assets/equipments.webp"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

// Consumer<HomePageProvider>(
// builder: (context,provider,child){
// return  Container(
// height: 300,
// width: double.infinity,
// child:
//
// StreamBuilder<QuerySnapshot>(
// stream: provider.GetNameStream(),
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
// return snapshot. data==null?CircularProgressIndicator(
// strokeWidth: 1,
// color: Colors.red,
// ):ListView(
// children: snapshot.data!.docs.map((DocumentSnapshot document){
// Map<String,dynamic> data=document.data()! as Map<String,dynamic>;
// if(snapshot.hasError){
// return Text('Somthing went wrong');
// }
// if(snapshot.connectionState==ConnectionState.waiting){
// return Text('Loading');
// }
// return
// Card(
// shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// color: Colors.teal,
// child: Padding(
// padding: EdgeInsets.all(8.0),
// child: Column(
// children: [
// text(data["GymName"]),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// text("Location"),
// text(data["GymLocation"]),
// ],
// ),
// SizedBox(height: 10,),Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// text("Charges"),
// text(data["GymCharges"]),
// ],
// ),
// ],
// ),
// ),
// );
// }).toList(),
// );
// }
// ),
// );
// }
// )
