import 'package:fit_plan/Screens/GymOwnerScreens/viewIncome.dart';
import 'package:flutter/material.dart';

import '../../Helper/color.dart';
import '../../Helper/helper.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewIncome()));
          } ,
        ),
        title: text("Add Income",size: 18.0,fontWeight: FontWeight.bold),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(40,),
                    bottomRight:Radius.circular(40,),
                  )
              ),
              height: MediaQuery.of(context).size.height/7,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:
                  text("Enter Details",size: 18.0)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
