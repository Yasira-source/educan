import 'package:educanapp/views/help_page/help_page.dart';
import 'package:educanapp/views/share_page/share_page.dart';
import 'package:educanapp/views/updates_page/updates_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/internet_connectivity/connectivity_provider.dart';
import '../../helper/internet_connectivity/no_internet.dart';
import '../profile/profile_screen.dart';
import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(
      {Key? key})
      : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }
  // static String routeName = "/home";
  int index = 0;

  final screens = [
    Body(),
    ProfileScreen(),

    // const Center(child: Text('Meet',style: TextStyle(fontSize: 72),),),
    HelpPage(),
    //awards page here
    UpdatesPage(),
    SharePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pageUI(),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: const Color(0xFF1A8F00),
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
            height: 60,
            backgroundColor: Colors.white,
            selectedIndex: index,
            animationDuration: const Duration(seconds: 3),
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                selectedIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                label: 'Account',
              ),

              NavigationDestination(
                icon: Icon(Icons.help),
                selectedIcon: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                label: 'Help',
              ),
              NavigationDestination(
                icon: Icon(Icons.tips_and_updates_outlined),
                selectedIcon: Icon(Icons.tips_and_updates,color: Colors.white,),
                label: 'Awards',
              ),

              NavigationDestination(
                icon: Icon(
                  Icons.share_outlined,
                  size: 30,
                ),
                selectedIcon: Icon(
                  Icons.share,
                  size: 30,
                  color: Colors.white,
                ),
                label: 'Share',
              ),
            ]),
      ),
    );
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(
      builder: (consumerContext, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? screens[index]
              : NoInternet();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
