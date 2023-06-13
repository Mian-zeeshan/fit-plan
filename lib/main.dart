import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fit_plan/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helper/Constant/app_constants.dart';
import 'Helper/Constant/color_constants.dart';
import 'Providers/ChatProviders/chat_provider.dart';
import 'Providers/ClientProvider/clientHomeProvider.dart';
import 'Providers/GymOwnerProvider/addEquipmentProvider.dart';
import 'Providers/GymOwnerProvider/addMembersProvider.dart';
import 'Providers/GymOwnerProvider/equipmentsProvider.dart';
import 'Providers/GymOwnerProvider/loginProvider.dart';
import 'Providers/GymOwnerProvider/memberProvider.dart';
import 'Providers/GymOwnerProvider/signupProvider.dart';
import 'Screens/ClientsScreens/clientHomePage.dart';
import 'Screens/GymOwnerScreens/splashPage.dart';

// void main(){
//   WidgetsFlutterBinding.ensureInitialized();
//     Firebase.initializeApp();//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp>_initialization=Firebase.initializeApp();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _initialization,
//       builder: (context,snapshot){
//         if(snapshot.hasError){
//           print('Somthing went Wrong');
//         }
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return Center(child: CircularProgressIndicator(),);
//         }
//         return MaterialApp(
//           home: SplashPage(
//
//           ),
//         );
//       }
//     );
//
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<AuthProvider>(
        //   create: (_) => AuthProvider(
        //     firebaseAuth: FirebaseAuth.instance,
        //     googleSignIn: GoogleSignIn(),
        //     prefs: this.prefs,
        //     firebaseFirestore: this.firebaseFirestore,
        //   ),
        // ),

        ChangeNotifierProvider<MemberProvider>(create: (_) => MemberProvider()),
        ChangeNotifierProvider<AddMemberProvider>(create: (_) => AddMemberProvider()),
        ChangeNotifierProvider<EquipmentsProvider>(create: (_) => EquipmentsProvider()),
        ChangeNotifierProvider<AddEquipmentProvider>(create: (_) => AddEquipmentProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<SignupProvider>(create: (_) => SignupProvider()),
        ChangeNotifierProvider<ClientHomeProvider>(create: (_) => ClientHomeProvider()),
        // Provider<ChatProvider>(
        //   create: (_) => ChatProvider(
        //     prefs: this.prefs,
        //     firebaseFirestore: this.firebaseFirestore,
        //     firebaseStorage: this.firebaseStorage,
        //   ),
        // ),
      ],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          primaryColor: ColorConstants.themeColor,
          primarySwatch: MaterialColor(0xfff5a623, ColorConstants.swatchColor),
        ),
        // home: ClientHomePage(),
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
