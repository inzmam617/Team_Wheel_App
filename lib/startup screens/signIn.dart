import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Services/apiService.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Verification/Verification.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String country = "+92";
  final countryPicker = const FlCountryCodePicker();
  TextEditingController email=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
            AppLocalizations.of(context)?.already_account ?? "",
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "SignUp");
              },
              child:  Text(
                AppLocalizations.of(context)?.signUp_Now ?? "",
              ))
        ],
      ),
      // backgroundColor:  const Color(0xffff0f0f0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SvgPicture.asset("assets/tamweeli_logo 1.svg"),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(

                height: 210,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3.0
                    )
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)?.login ?? "",
                          style: const TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)?.email ?? "",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xffff0f0f0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextField(
                            controller: email,
                            //keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              hintText:  AppLocalizations.of(context)?.email ?? "",
                            ),
                            onChanged: (value) {
                              //email.text=value;
                              // this.phoneNo=value;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(45))
                        ),

                        height: 45,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _onSubmit,
                          child:_isLoading
                              ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ) : const Center(
                            child: Text("Log In",style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),


            // Transform.translate(
            //   offset: const Offset(0.0, -60),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(100)),
            //     height: 75,
            //     width: 75,
            //     child: Padding(
            //       padding: const EdgeInsets.all(10),
            //       child: ElevatedButton(
            //           style: ButtonStyle(
            //             elevation: MaterialStateProperty.all(0.1),
            //             backgroundColor: MaterialStateProperty.all(Colors.blue),
            //             shape:
            //                 MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(100),
            //               ),
            //             ),
            //           ),
            //           onPressed:_isLoading ? null : _onSubmit,
            //           child:_isLoading
            //               ? Container(
            //             width: 24,
            //             height: 24,
            //             padding: const EdgeInsets.all(2.0),
            //             child: const CircularProgressIndicator(
            //               color: Colors.white,
            //               strokeWidth: 3,
            //             ),
            //           ) :Transform.rotate(
            //               angle: 180 * math.pi / 180,
            //               child: const Icon(
            //                 Icons.arrow_back,
            //                 size: 30,
            //               ))),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }

  var _isLoading = false;
  final __isLoading = false;
  void _onSubmit() {

    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
          () => setState(() => _isLoading = false),
    ).then((value) {
      final snackBar = SnackBar(
        content:  Text(
          AppLocalizations.of(context)?.please_wait ?? ""

        ,style: const TextStyle(color: Colors.white),),
        backgroundColor: (Colors.black),
        action: SnackBarAction(
          label: AppLocalizations.of(context)?.dismiss ?? "",
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if(email.text==''){
        showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title:  Text(
              AppLocalizations.of(context)?.problem ??  "",
            ),
            content:  Text(
              AppLocalizations.of(context)?.please_enter_email ??  "",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
      else{
        ApiServices.signInAPi(email.text).then((success)async{
          if(success=="error"){
            showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text("Error Occured"),
                content: const Text("Please Try again"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
          }
          else if(success=="error1"){
            showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog(
                title: const Text("Error Occured"),
                content: const Text("Email Not Found"),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );

          }
          else{
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('name', success);
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return  VerificationScreen(email: email.text,);
            }));
            // showDialog(
            //     context: context,
            //     builder: (BuildContext context) {
            //       return StatefulBuilder(
            //           builder: (context,setState){
            //             return AlertDialog(
            //               title:  Text(
            //                 AppLocalizations.of(context)?.verification ?? ""
            //
            //               ),
            //               content: Form(
            //                 key: _formKey,
            //                 child: Column(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: <Widget>[
            //                     TextFormField(
            //                       controller: _otpController,
            //                       decoration: const InputDecoration(
            //                         labelText: 'OTP',
            //                       ),
            //                       validator: (value) {
            //                         if (value!.isEmpty) {
            //                           return 'Enter OTP';
            //                         }
            //                         return null;
            //                       },
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               actions: <Widget>[
            //                 Transform.translate(
            //                   offset: const Offset(0.0, -10),
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.circular(100)),
            //                     height: 65,
            //                     width: 65,
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(1),
            //                       child: ElevatedButton(
            //                           style: ButtonStyle(
            //                             elevation: MaterialStateProperty.all(0.1),
            //                             backgroundColor: MaterialStateProperty.all(Colors.blue),
            //                             shape:
            //                             MaterialStateProperty.all<RoundedRectangleBorder>(
            //                               RoundedRectangleBorder(
            //                                 borderRadius: BorderRadius.circular(100),
            //                               ),
            //                             ),
            //                           ),
            //                           onPressed:__isLoading ? null : __onSubmit,
            //                           child:__isLoading
            //                               ? Container(
            //                             width: 24,
            //                             height: 24,
            //                             padding: const EdgeInsets.all(2.0),
            //                             child: const CircularProgressIndicator(
            //                               color: Colors.white,
            //                               strokeWidth: 3,
            //                             ),
            //                           ) :Transform.rotate(
            //                               angle: 180 * math.pi / 180,
            //                               child: const Icon(
            //                                 Icons.arrow_back,
            //                                 size: 30,
            //                               ))),
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             );
            //           });
            //     });
            setState(() {

            });
          }
        });
      }
    });

  }

  void __onSubmit() {
    final snackBar = SnackBar(
      content: const Text('Verifying',style: TextStyle(color: Colors.white),),
      backgroundColor: (Colors.black),
      action: SnackBarAction(
        label: 'dismiss',
        onPressed: () {
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar).setState;
    if (_formKey.currentState!.validate()) {
      ApiServices.verifyOpt(email.text, _otpController.text).then((value) {
        if(value=="success"){
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.pushNamed(context, "botombar");
        }else{
          final snackBar = SnackBar(
            content: const Text('Invalid OTP',style: TextStyle(color: Colors.white),),
            backgroundColor: (Colors.black),
            action: SnackBarAction(
              label: 'dismiss',
              onPressed: () {
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar).setState;
          Navigator.of(context).pop();
        }
      });

    }

  }
}

