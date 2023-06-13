import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DpView extends StatelessWidget {
  final Function() onTap;

  const DpView({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CircularPercentIndicator(
        radius: 18.0,
        lineWidth: 3.0,
        percent: 0,
        center: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
            // user?.profileImage?.url == '' || user?.profileImage == null || user == null
            //     ?
            'https://static.vecteezy.com/system/resources/previews/004/991/321/original/picture-profile-icon-male-icon-human-or-people-sign-and-symbol-vector.jpg',
            // : '${StaticInfo.baseUrl}${user.profileImage?.url ?? ''}',
          ),
        ),
        backgroundColor: Colors.white,
        progressColor: Colors.green,
      ),
    );
  }
}
