import 'package:fit_plan/Screens/GymOwnerScreens/viewExpenses.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/viewIncome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Helper/color.dart';
import '../../Helper/helper.dart';

class RevenueExpenses extends StatefulWidget {
  const RevenueExpenses({Key? key}) : super(key: key);

  @override
  _RevenueExpensesState createState() => _RevenueExpensesState();
}

class _RevenueExpensesState extends State<RevenueExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: background,
        title: text("Revenue & Expenses",size: 18.0,fontWeight: FontWeight.bold),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Image.asset(
                    fit:BoxFit.fill,
                    "assets/income.webp",
                  ),

                  SizedBox(height: 15,),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person),
                          text("View Incomes",color: background,size: 16.0,fontWeight: FontWeight.bold)
                        ],
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewIncome()));
                      }),
                  // SizedBox(height: 5,),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          text("Add New Incomes",color: background,size: 16.0,fontWeight: FontWeight.bold)
                        ],
                      ),
                      onPressed: (){
                      }),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [

                  Image.asset(
                    fit:BoxFit.fill,
                    "assets/expense.webp",
                  ),

                  SizedBox(height: 15,),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person),
                          text("View Expense",color: background,size: 16.0,fontWeight: FontWeight.bold)
                        ],
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ViewExpenses()));
                      }),
                  // SizedBox(height: 5,),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 40,
                      color: buttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          text("Add New Expense",color: background,size: 16.0,fontWeight: FontWeight.bold)
                        ],
                      ),
                      onPressed: (){
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
