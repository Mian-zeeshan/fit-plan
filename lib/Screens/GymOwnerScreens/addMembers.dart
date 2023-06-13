import 'package:fit_plan/Providers/GymOwnerProvider/addMembersProvider.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/members.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/color.dart';
import '../../Helper/helper.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key}) : super(key: key);

  @override
  _AddMembersState createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  @override
  Widget build(BuildContext context) {
    final addMember = Provider.of<AddMemberProvider>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: background,
        ),
        height: 70,
        child: InkWell(
          onTap: () {
            addMember.GetMemberControllerValues().then((value) => {
                  addMember.uploadFile().then((value) => {
                        addMember.WriteDataOfMembersInFirebase(context),
                      }),
                });
          },
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: background,
            ),
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  color: textColor,
                ),
                text(" Confrim Details", size: 16.0, fontWeight: FontWeight.bold),
              ],
            )),
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColor),
        backgroundColor: background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Members()));
          },
        ),
        title: text("Add Members", size: 18.0, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              height: MediaQuery.of(context).size.height / 8,
              child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: text("Enter Details", size: 16.0, fontWeight: FontWeight.bold)),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: text("   Name", size: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    addDataTextField("Enter the Name", addMember.addMemberControllers.memberNameController),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: text("   Phone Number", size: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    addDataTextField(
                        "Enter the Phone Number", addMember.addMemberControllers.memberPhoneNumberController),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      // mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width / 4,
                            height: 45,
                            color: buttonColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            child: text("Pick Image", size: 16.0, fontWeight: FontWeight.bold),
                            onPressed: () {
                              addMember.pickImage();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: textFieldColor, width: 3)),
                          child: addMember.tempImage == null
                              ?  ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                "assets/profilePic.jpg",
                                fit: BoxFit.fill,
                              ))
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    addMember.tempImage,
                                    fit: BoxFit.fill,
                                  )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: text("   Fee", size: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    addDataTextField("Enter the Fee", addMember.addMemberControllers.memberFeeController),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: text("   Pay Date", size: 16.0, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(
                      height: 5,
                    ),
                    addDataTextField("Enter the Pay Date", addMember.addMemberControllers.memberPayDateController),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
