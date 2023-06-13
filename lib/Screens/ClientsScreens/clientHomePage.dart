import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_plan/Helper/color.dart';
import 'package:fit_plan/Providers/ClientProvider/clientHomeProvider.dart';
import 'package:fit_plan/Screens/ClientsScreens/gymDetailData.dart';
import 'package:fit_plan/Screens/ClientsScreens/gymDetailsPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Helper/helper.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  _ClientHomePageState createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  List<Property> StandardGymList = [
    Property(
      "SALE",
      "LA Fitness",
      "50Rs-hr",
      "Iqbal Town",
      "Zeeshan Javed",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.09.10 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.09.10 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Gold Gym",
      "50Rs-hr",
      "Miami",
      "Zeeshan Javed",
      "4.6",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.09.09 PM (1).jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.09.09 PM (1).jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Planet Fitness",
      "50Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.09.09 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.09.09 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Pure Gym",
      "50Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.09.06 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.09.06 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
  ];

  List<Property> StanderdGymList = [
    Property(
      "SALE",
      "LA Fitness",
      "70Rs-hr",
      "Iqbal Town",
      "Zeeshan Javed",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.13 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.13 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Gold Gym",
      "70Rs-hr",
      "Miami",
      "Zeeshan Javed",
      "4.6",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.12 PM (1).jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.12 PM (1).jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Planet Fitness",
      "70Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.12 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.12 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Pure Gym",
      "70Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.11 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.11 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
  ];
  List<Property> PremiumGymList = [
    Property(
      "SALE",
      "LA Fitness",
      "100Rs-hr",
      "Iqbal Town",
      "Zeeshan Javed",
      "4.4",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.15 PM (1).jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.15 PM (1).jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Gold Gym",
      "100Rs-hr",
      "Miami",
      "Zeeshan Javed",
      "4.6",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.15 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.15 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Planet Fitness",
      "100Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.14 PM (1).jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.14 PM (1).jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
    Property(
      "RENT",
      "Pure Gym",
      "100Rs-hr",
      "California",
      "Zeeshan Javed",
      "4.1",
      "The living is easy in this impressive, generously proportioned contemporary residence with lake and ocean views, located within a level stroll to the sand and surf.",
      "assets/WhatsApp Image 2023-06-13 at 4.37.14 PM.jpeg",
      "assets/WhatsApp Image 2023-06-13 at 4.37.14 PM.jpeg",
      [
        "assets/WhatsApp Image 2023-06-13 at 3.57.51 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.20 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.21 PM.jpeg",
        "assets/WhatsApp Image 2023-06-13 at 3.59.22 PM.jpeg",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final clientHomePageProvider = Provider.of<ClientHomeProvider>(context, listen: false);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: textColor),
          backgroundColor: background,
          bottom: TabBar(
            indicatorWeight: 5,
            indicatorColor: buttonColor,
            unselectedLabelColor: textColor,
            labelColor: textColor,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overlayColor: MaterialStateProperty.all<Color>(Colors.red),
            tabs: [
              Tab(
                text: "Basic",
              ),
              Tab(text: "Standerd"),
              Tab(text: "Premium"),
            ],
          ),
          title: text('Home Page', size: 20.0),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: StandardGymList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detail(property: StandardGymList[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              margin: EdgeInsets.only(bottom: 24),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(StandardGymList[index].frontImage),
                                  fit: BoxFit.cover,
                                )),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.5, 1.0],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.9),
                                    ],
                                  )),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[700],
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        width: 80,
                                        padding: EdgeInsetsDirectional.symmetric(vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Open Now",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                StandardGymList[index].name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                StandardGymList[index].price,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        StandardGymList[index].location,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(),

                                                  // Row(
                                                  //
                                                  //   children: [
                                                  //
                                                  //     Icon(Icons.star,
                                                  //       color: Colors.yellow[700],
                                                  //       size: 14,
                                                  //
                                                  //     ),
                                                  //
                                                  //     SizedBox(width: 4,),
                                                  //
                                                  //     Text(property.review + "Reviews",
                                                  //     style: TextStyle(
                                                  //       color: Colors.white,
                                                  //       fontSize: 14,
                                                  //     ),
                                                  //     )
                                                  //
                                                  //
                                                  //   ],
                                                  //
                                                  // )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: StanderdGymList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detail(property: StanderdGymList[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              margin: EdgeInsets.only(bottom: 24),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(StanderdGymList[index].frontImage),
                                  fit: BoxFit.cover,
                                )),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.5, 1.0],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.9),
                                    ],
                                  )),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[700],
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        width: 80,
                                        padding: EdgeInsetsDirectional.symmetric(vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Open Now",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                StanderdGymList[index].name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                StanderdGymList[index].price,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        StanderdGymList[index].location,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: PremiumGymList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Detail(property: PremiumGymList[index])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(
                              margin: EdgeInsets.only(bottom: 24),
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(PremiumGymList[index].frontImage),
                                  fit: BoxFit.cover,
                                )),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.5, 1.0],
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.9),
                                    ],
                                  )),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow[700],
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        width: 80,
                                        padding: EdgeInsetsDirectional.symmetric(vertical: 4),
                                        child: Center(
                                          child: Text(
                                            "Open Now",
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                PremiumGymList[index].name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                PremiumGymList[index].price,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        PremiumGymList[index].location,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
