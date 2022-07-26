import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:educanapp/routes.dart';
import 'package:educanapp/views/home/home_screen.dart';
import 'package:educanapp/views/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/internet_connectivity/connectivity_provider.dart';

void main() {
  // await UserSimplePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 String? _pname;
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _pname = (prefs.getString('uid') ?? '');

    });
  }

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: _pname==""? OnboardingPage():HomeScreen(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Educan App',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        // home: TestPage(),
        home: AnimatedSplashScreen(
          duration:3000,
          splash: Column(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children:[

                Image.asset(
                  'assets/images/ic_logo.png',height: 220,
                ),
                // SizedBox(height: 8),
                const Text("Values Beyond School",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Lato',fontSize: 20),)
              ]
          ),
          nextScreen: _pname==""? OnboardingPage():HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          // pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Colors.white,
          splashIconSize: 250,
        ),
        routes: Routes.routes,
      )
    );


  }
}
