import 'package:flutter/material.dart';

import '../HomeScreens/ScreenOne.dart';
import '../HomeScreens/ScreenTwo.dart';
import '../HomeScreens/Screenthree.dart';
import '../HomeScreens/profilePage.dart';
import '../model/viewCarModel.dart';

class botombar extends StatefulWidget {
  const botombar({Key? key}) : super(key: key);

  @override
  State<botombar> createState() => _botombarState();
}

class _botombarState extends State<botombar> {
  static const IconData bell = IconData(0xf3e1);
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //pageController.jumpToPage(index);

    // Navigator.pushReplacement(context,PageRouteBuilder(
    //   pageBuilder: (context, animation1, animation2) => _children[_selectedIndex],
    // ));
  }
  final screens =[
    const screenOne(),
    const screenthree(balance: " ",),
    screenTwo(monthlyInstallment: " ",vehicles: Dataa(),),
    const profilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
               // unselectedItemColor: Colors.blue,
                selectedItemColor: Colors.purple,
                items:  const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bookmark_border), label: 'Favourite'),
                  BottomNavigationBarItem(

                      icon: Icon(Icons.notifications_outlined), label: 'Favourite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline_sharp), label: 'Favourite'),

                ],
              ),
            )),
        body:  screens[_selectedIndex]

    );
  }
}
