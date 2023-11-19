import 'package:flutter/material.dart' ;
import 'package:zoom_clone/screens/bottom_navigation_screens/contacts.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/home_page.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/meeting_history.dart';
import 'package:zoom_clone/screens/bottom_navigation_screens/setting.dart';

import '../Pallate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<Widget> children = [
    HomePage(),
    History(),
    Contacts(),
    Setting(),
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 13.0),
              child: Icon(Icons.home),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.info_outline),
                ),
              )
            ],
            elevation: 0.2,
            backgroundColor: Colors.grey.shade900,
            centerTitle: true,
            title: Text(
              "MeetWith",
              style: TextStyle(color: AppColors.theme['primaryTextColor']),
            ),
          ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels : true,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contacts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),

      ),
    );
  }



  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return History();
      case 2:
        return Contacts();
      default:
        return Setting();
    }
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
