import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Helper/appConfig.dart';
import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/sideMenuProvider.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/loginPage.dart';
import 'package:fit_plan/tabspage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/helper.dart';


class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();

}

class _SideMenuState extends State<SideMenu> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
  Stream<DocumentSnapshot> snapshot = FirebaseFirestore.instance
      .collection("GymOwner").doc("tjVBubcMicXlVYCY8y4MgmHaBDm1").snapshots();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ChangeNotifierProvider<SideMenuProvider>(
        create: (context)=>SideMenuProvider(),
        child: Consumer<SideMenuProvider>(
          builder: (context,provider,child){
            return  ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: background,
                  child: DrawerHeader(
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 135,
                         width: MediaQuery.of(context).size.width,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: provider.GetProfieImage(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                              return snapshot. data==null?Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.red,
                                ),
                              ):ListView(
                                children: snapshot.data!.docs.map((DocumentSnapshot document){
                                  Map<String,dynamic> data=document.data()! as Map<String,dynamic>;
                                  if(snapshot.hasError){
                                    return Text('Somthing went wrong');
                                  }
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return Text('Loading');
                                  }
                                  return
                                    Container(

                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 40.0,
                                              backgroundImage: NetworkImage(
                                                data["ProfileImage"]!=null? data["ProfileImage"]:"",),
                                            ),
                                            SizedBox(height: 10),
                                            text(data["UserName"],size: 18.0,fontWeight: FontWeight.bold),
                                          ],
                                        ),

                                    );

                                }).toList(),
                              );

                            },


                          ),
                        ),

                      ],
                    ),

                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home,color: background),
                  title: text("Home",color: background),
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 0)),
                    )
                  },
                ),
                Divider(thickness: 2,color: background,),
                ListTile(
                  leading: Icon(Icons.search,color: background),
                  title: text("Search",color: background),
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 1)),
                    ),
                  },
                ),
                Divider(thickness: 2,color: background,),
                ListTile(
                  leading: Icon(Icons.settings,color: background),
                  title: text("Profile",color: background),
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => TabsPage(selectedIndex: 2)),
                    ),
                  },

                ),
                Divider(thickness: 2,color: background,),
                ListTile(
                  // tileColor: buttonColor,
                  leading: Icon(Icons.person,color: background,),
                  title: text("Logout",color: background),
                  onTap: () => {
                    _signOut(),
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ),
                  },
                ),

              ],
            );
          },
        ),
      ),
    );
  }
}