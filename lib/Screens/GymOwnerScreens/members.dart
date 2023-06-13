import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/addMembers.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';

import '../../Helper/appConfig.dart';
import '../../Helper/color.dart';
import '../../Helper/helper.dart';
import '../../Providers/GymOwnerProvider/memberProvider.dart';
import '../../side_menu.dart';
import '../ChatPages/chat_page.dart';

class Members extends StatefulWidget {
  const Members({Key? key}) : super(key: key);

  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    final memberProvider = Provider.of<MemberProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        iconTheme: IconThemeData(color: textColor),
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
              )),
        ),
        title: text("Members",size: 18.0,fontWeight: FontWeight.bold),
      ),
      bottomNavigationBar:  Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          color:background,
        ),
        width: MediaQuery.of(context).size.width,

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddMembers()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: textColor,),
                    text(" Add Members",size: 16.0,fontWeight: FontWeight.bold),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              customSearchContainer(context),
               Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  width: double.infinity,
                  child:
                  StreamBuilder<QuerySnapshot>(
                      stream: memberProvider.GetMembersStream(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        return snapshot. data==null?Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.red,
                            ),
                          ),
                        ):ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document){

                            Map<String,dynamic> data=document.data()! as Map<String,dynamic>;
                            AppConfig.gymMembersCount = snapshot.data!.docs.length;
                            if(snapshot.hasError){
                              return Text('Somthing went wrong');
                            }
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Center(child: Text('Loading...'));
                            }
                            return
                              Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                color: cardColor,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                      data["Image"]!=null?Image.network(  data["Image"],width: 70,height: 70, fit: BoxFit.fill,):Image.asset("assets/gym Image.jpg",width: 70,height: 70, fit: BoxFit.fill,),

                                          // Image.network( "data["Image"]!=null? data["Image"]:null",width: 70,height: 70, fit: BoxFit.fill,),
                                          Column(
                                            children: [
                                              text(data["MemberName"],size: 16.0,fontWeight: FontWeight.bold),
                                              text(data["MemberPhoneNumber"]),
                                              text(data["MemberFee"]),
                                              text(data["MemberPayDate"]),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: (){
                                            var Id=  document.id;
                                            memberProvider.DeleteMember(Id);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: buttonColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(thickness: 1,color: Colors.grey,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: ()async{

                                                  await FlutterPhoneDirectCaller.callNumber(data["MemberPhoneNumber"]);
                                                  // provider.CallNumber(data["MemberPhoneNumber"]);
                                                },
                                                icon: Icon(
                                                  Icons.call,
                                                  color: buttonColor,
                                                ),
                                              ),
                                              text("call",size: 16.0)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: (){
                                                  late String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
                                                  AppConfig.groupChatId ="${currentUserId.toString()+ "-" + data["MemberId"]}";
                                                  // ChatPageArguments c = ChatPageArguments( peerId: data["MemberId"] ,peerAvatar:data["Image"] , peerNickname: data["MemberName"], );
                                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                                  //     ChatPage(arguments: c),
                                                  //     // ChatScreen1()
                                                  // ));
                                                },
                                                icon: Icon(
                                                  Icons.message,
                                                  color: buttonColor,
                                                ),
                                              ),
                                              text("Meassage",size: 16.0)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                onPressed: (){
                                                },
                                                icon: Icon(
                                                  Icons.payment,
                                                  color: buttonColor,
                                                ),
                                              ),
                                              text("pay",size: 16.0)
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                          }).toList(),
                        );
                      }
                  ),
                )

            ],
          ),
        ),
      ),
    );
  }
}
