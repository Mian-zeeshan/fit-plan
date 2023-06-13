import 'package:flutter/material.dart';

import '../../Helper/color.dart';
import '../../Helper/helper.dart';
import 'addIncome.dart';
import 'homePage.dart';

class ViewIncome extends StatefulWidget {
  const ViewIncome({Key? key}) : super(key: key);

  @override
  _ViewIncomeState createState() => _ViewIncomeState();
}

class _ViewIncomeState extends State<ViewIncome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            color:background,
          ),
          height: 50,
          child: Column(
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddIncome()));

                  },
                  child:
                  customBottomNevBar(context,"Add Income")
              ),
            ],
          ) ,
        ),
          appBar: AppBar(
            backgroundColor: background,
            leading: IconButton(
              icon:Icon(Icons.arrow_back_ios),
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
              } ,
            ),
            title: text("View Income",size: 18.0,fontWeight: FontWeight.bold),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customSearchContainer(context),
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
                              text("image",size: 16.0,fontWeight: FontWeight.bold),

                              // Image.network( "data["Image"]!=null? data["Image"]:null",width: 70,height: 70, fit: BoxFit.fill,),
                              Column(
                                children: [
                                  text("Name",size: 16.0,fontWeight: FontWeight.bold),
                                  text("Amount"),
                                  text("Date"),
                                  text("Details"),
                                ],
                              ),
                              IconButton(
                                onPressed: (){
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: buttonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
