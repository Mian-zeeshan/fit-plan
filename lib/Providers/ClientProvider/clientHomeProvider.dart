import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ClientHomeProvider extends ChangeNotifier{

  launchMap( lat , long) {
    MapsLauncher.launchCoordinates(lat, long);

  }

  GetClientHomePageStream(){
    final Stream<QuerySnapshot> ownersStream=FirebaseFirestore.instance.collection("GymOwner").snapshots();
    return ownersStream;
  }
}