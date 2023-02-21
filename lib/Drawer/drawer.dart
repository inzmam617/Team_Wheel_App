import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamwheelapp/startup%20screens/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class drawer extends StatefulWidget {
  const drawer({Key? key}) : super(key: key);

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  String name=" ";
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name').toString();
    print(name);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color:  Color(0xff445cd4),
          ),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(name,style: const TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.white),)),
        ),
        ListTile(
          title:   Text(
            AppLocalizations.of(context)?.your_profile ?? ""

          ),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1.5,thickness: 1.5,),
        ListTile(
          title:   Text(
              AppLocalizations.of(context)?.exit ?? ""
          ),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1.5,thickness: 1.5,),
        ListTile(
          title:   Text(
              AppLocalizations.of(context)?.logout ?? ""
          ),
          onTap: () {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text("Logout?"),
                content: const Text("Are you sure you want to logout?",),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel",),
                  ),
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Logout',),
                    onPressed: () {
                      RemoveAll();
                      // if (Platform.isAndroid) {
                      //   SystemNavigator.pop();
                      // } else if (Platform.isIOS) {
                      //   exit(0);
                      // }
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          const splashScreen()), (Route<dynamic> route) => false);
                      //Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>splashScreen(),));
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const Divider(height: 1.5,thickness: 1.5,),
      ],
    ));
  }
  late SharedPreferences user;
  Future<void> RemoveAll() async{
    user=await SharedPreferences.getInstance();
    user.remove('name');
  }
}
