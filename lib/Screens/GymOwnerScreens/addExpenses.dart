import 'package:fit_plan/Screens/GymOwnerScreens/viewExpenses.dart';
import 'package:flutter/material.dart';

import '../../Helper/color.dart';
import '../../Helper/helper.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewExpenses()));
          } ,
        ),
        title: text("Add Expenses",size: 18.0,fontWeight: FontWeight.bold),
      ),
    body: Column(
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
    );
  }
}
