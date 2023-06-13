import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Providers/GymOwnerProvider/equipmentsProvider.dart';
import 'package:fit_plan/Screens/GymOwnerScreens/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/helper.dart';
import '../../side_menu.dart';
import 'addEquipments.dart';

class Equipments extends StatefulWidget {
  const Equipments({Key? key}) : super(key: key);

  @override
  _EquipmentsState createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {
  var Id;
  @override
  Widget build(BuildContext context) {
    final equipmentProvider = Provider.of<EquipmentsProvider>(context,listen: false);
    return Scaffold(
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddEquipments(ClassName: "Add Equipments",)));

              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                  color:background,
                ),
                width: MediaQuery.of(context).size.width,

                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,color: textColor,),
                    text(" Add Equipments",size: 16.0,fontWeight: FontWeight.bold),
                  ],
                )),
              ),
            ),
          ],
        ) ,
      ),
      appBar: AppBar(
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
        backgroundColor: background,
        title: text("Equipments",size: 18.0,fontWeight: FontWeight.bold),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            customSearchContainer(context),
                    Container(
                    height: MediaQuery.of(context).size.height/1.5,
                    width: double.infinity,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: equipmentProvider.GetEquipmentsStream(),
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
                                Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  color: cardColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        data["Image"]!=null?Image.network(  data["Image"],width: 70,height: 70, fit: BoxFit.fill,):Image.asset("assets/gym Image.jpg",width: 70,height: 70, fit: BoxFit.fill,),
                                        Column(
                                          children: [
                                            text(data["EquipmentName"],size: 16.0,fontWeight: FontWeight.bold),
                                            text(data["Details"]),
                                            text(data["Date"]),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: (){
                                            Id=document.id;
                                            equipmentProvider.DeleteEquipment(Id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: buttonColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                            }).toList(),
                          );
                        }
                    ),
                  )
          ],
        ),
      ) ,
    );
  }
}
