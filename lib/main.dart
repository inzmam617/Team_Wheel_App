import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teamwheelapp/provider/local_provdier.dart';
import 'package:teamwheelapp/startup%20screens/chooseanguage.dart';
import 'package:teamwheelapp/startup%20screens/signIn.dart';
import 'package:teamwheelapp/startup%20screens/signup.dart';
import 'package:teamwheelapp/startup%20screens/splash.dart';
import 'HomeScreens/ScreenOne.dart';
import 'HomeScreens/ScreenTwo.dart';
import 'HomeScreens/Screenthree.dart';
import 'HomeScreens/profilePage.dart';
import 'bottomnavbar/bottombar.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (BuildContext context,child) {
        final provider = Provider.of<LocalProvider>(context);
        return MaterialApp(
          locale: provider.local,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            initialRoute: "splashScreen",
            routes: {
              "splashScreen"  : (context) => const splashScreen(),
              "chooseanguage" : (context) => const chooseanguage(),
              "SignIn" : (context) => const SignIn(),
              "SignUp" : (context) => const Signup(),
              "screenOne":(context) =>  const screenOne(),
              "profilepage": (context) => const profilepage(),
              "botombar": (context) => const botombar(),
              "viewCar": (context) => const screenthree(balance: " ",),
              "Drawer" : (context) => const Drawer(),
            }

        );
      }, create: (BuildContext context) => LocalProvider(),
      //child:
    );
  }
}
