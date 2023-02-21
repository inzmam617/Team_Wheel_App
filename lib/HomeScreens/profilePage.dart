import 'package:flutter/material.dart';

import '../Drawer/drawer.dart';
import '../startup screens/chooseanguage.dart';
import '../startup screens/signIn.dart';
import '../startup screens/signup.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const chooseanguage(),
    const SignIn(),
    const Signup(),
    const profilepage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              _children[_selectedIndex],
        ));
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //     decoration: const BoxDecoration(
      //       borderRadius: BorderRadius.all(Radius.circular(30)),
      //       boxShadow: [
      //         BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      //       ],
      //     ),
      //     child: ClipRRect(
      //       borderRadius: const BorderRadius.only(
      //         topLeft: Radius.circular(30.0),
      //         topRight: Radius.circular(30.0),
      //       ),
      //       child: BottomNavigationBar(
      //         type: BottomNavigationBarType.fixed,
      //         showSelectedLabels: false,
      //         showUnselectedLabels: false,
      //         selectedFontSize: 12,
      //         unselectedFontSize: 12,
      //         currentIndex: _selectedIndex,
      //         onTap: _onItemTapped,
      //         unselectedItemColor: Colors.blue,
      //         selectedItemColor: Colors.amber[800],
      //         items: const <BottomNavigationBarItem>[
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.home_filled),label: 'Favourite' ),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.bookmark),label: 'Favourite' ),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.album),label: 'Favourite' ),
      //           BottomNavigationBarItem(
      //               icon: Icon(Icons.person_outlined),label: 'Favourite' ),
      //         ],
      //       ),
      //     )
      // ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Image.asset("assets/more.png"));
        }),
        //automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color(0xff445cd4),
      ),
      drawer:const Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
        //width: (width)/3,
        child: drawer(),
      ),
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -10),
            child: Image.asset("assets/Ellipse 46.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          height: 100,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(360)),
                            child: Image.asset("assets/img.jpeg"),
                          ),
                        ),
                      ),
                    ),
                    textfield( AppLocalizations.of(context)?.your_profile ?? ""),
                    textfield( AppLocalizations.of(context)?.national_id ?? ""),
                    textfield( AppLocalizations.of(context)?.mobile_num ?? ""),
                    textfield( AppLocalizations.of(context)?.email ?? ""),
                    textfield( AppLocalizations.of(context)?.date_birth ?? ""),
                    textfield( AppLocalizations.of(context)?.gender ?? ""),
                    textfield( AppLocalizations.of(context)?.monthly_salary ?? ""),
                    textfield( AppLocalizations.of(context)?.bank_name ?? ""),
                    textfield( AppLocalizations.of(context)?.city ?? ""),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child:  Text(
                                AppLocalizations.of(context)?.edit_profile ?? ""
                            )))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget textfield(name) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          name,
          style: const TextStyle(fontSize: 13),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          elevation: 10,
          child: Container(
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextFormField(
              validator: (value) {
                return null;
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintText: 'Enter $name'),
            ),
          ),
        ),
      )
    ],
  );
}
