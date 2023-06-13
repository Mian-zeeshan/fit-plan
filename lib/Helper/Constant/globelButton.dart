import 'package:flutter/material.dart';

class GlobalButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final bool isActive;

  GlobalButton({required this.title, required this.onTap, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 47,
      minWidth: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: isActive ? Theme.of(context).primaryColor : Color(0xff0606064D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: onTap,
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
