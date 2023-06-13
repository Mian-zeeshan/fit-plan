import 'package:fit_plan/Helper/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Controllers/GymOwnerController/loginController.dart';

LoginController loginController = LoginController();
Text text(
  text, {
  color: textColor,
  size = 14.0,
  fontWeight: FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
  );
}

Widget textField(
  String hint,
  controller, {
  maxLines = 1,
  isPassword = false,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child:
    TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return hint;
          }
          return null;
        },
      style: TextStyle(color: textColor),
      obscureText: isPassword,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: textFieldColor,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: textColor, fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget signUpTextField(
    String hint,
    controller,
    FocusNode focusNode,
    {
      maxLines = 1,
      isPassword = false,
    }) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child:
    TextFormField(
      autofocus: true,
      focusNode: focusNode,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return hint;
        }
        return null;
      },
      onFieldSubmitted: (value){
        focusNode.nextFocus();
        //FocusScope.of(context).nextFocus();
      },
      style: TextStyle(color: textColor),
      obscureText: isPassword,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        fillColor: textFieldColor,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: textColor, fontWeight: FontWeight.normal),
      ),
    ),
  );
}
showSnackBar(context, message){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:text(message,)));
}

  Widget customHomePageCard(
      String text1,
      String text2,
      String imagePath,
      ){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color:cardColor,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 110,
            height: 80,
            child: Image.asset(
                fit:BoxFit.fill,
                imagePath,
                ),
          ),
          text(text1,size: 16.0,fontWeight: FontWeight.bold),
          text(text2,size: 16.0,fontWeight: FontWeight.bold)
        ],
      ),
    ),
  );
  }

  Widget addDataTextField(
      String hint,
      controller,
      ){
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: TextFormField(
      controller: controller,
      cursorColor: textColor,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        fillColor: textFieldColor,
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: textColor, fontWeight: FontWeight.normal),
      ),
    ),
  );

  }

  Widget customSearchContainer(context){
  return
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
        child: Card(
          color: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,color: textColor,),
              hintText: "Search ",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white30),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    ),
  );
  }
  Widget customBottomNevBar(context,String text1){
  return
    Container(
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
          text(text1,size: 16.0,fontWeight: FontWeight.bold),
        ],
      )),
    );
  }


