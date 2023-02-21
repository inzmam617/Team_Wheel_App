import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

import '../Services/apiService.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String country = "+92";

  final countryPicker = const FlCountryCodePicker();
  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Text(
             AppLocalizations.of(context)?.already_account ??  "",
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "SignIn");
              },
              child:  Text(
                AppLocalizations.of(context)?.signIn_Now ??  "",
              ))
        ],
      ),
     // backgroundColor:  const Color(0xffff0f0f0),
      appBar: AppBar(
        title:  Text(
          AppLocalizations.of(context)?.signUp ??  "",
          style: const TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "SignIn");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
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
                height: 220,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.only(left: 15,top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)?.email ??  "",
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
                              hintText:  AppLocalizations.of(context)?.email ??  "",
                            ),
                            onChanged: (value) {
                              //email.text=value;
                            },
                          ),
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
                            AppLocalizations.of(context)?.firstname ??  "",
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
                            controller: name,
                            //keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context)?.firstname ??  "",
                            ),
                            onChanged: (value) {
                              //name.text=value;
                              // this.phoneNo=value;
                            },
                          ),
                          // Row(
                          //   children: <Widget>[
                          //     GestureDetector(
                          //       onTap: () async {
                          //         final code = await countryPicker.showPicker(
                          //             context: context);
                          //         if (code != null) {
                          //           setState(() {
                          //             country = code.dialCode;
                          //           });
                          //         }
                          //       },
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(8.0),
                          //         child: Row(
                          //           children: [
                          //             Container(
                          //               child: Text(country,
                          //                   style: const TextStyle(
                          //                       color: Colors.black)),
                          //             ),
                          //             const SizedBox(
                          //               width: 5,
                          //             ),
                          //             Transform.rotate(
                          //                 angle: 270 * math.pi / 180,
                          //                 child: const Icon(
                          //                   Icons.arrow_back_ios_new,
                          //                   size: 15,
                          //                 ))
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     Container(
                          //       height: 18,
                          //       width: 1.5,
                          //       color: Colors.black54,
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     Expanded(
                          //       child: TextField(
                          //         keyboardType: TextInputType.phone,
                          //         decoration: const InputDecoration(
                          //           border: InputBorder.none,
                          //           hintText: "Phone Number",
                          //         ),
                          //         onChanged: (value) {
                          //           // this.phoneNo=value;
                          //         },
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0.0, -60),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                height: 75,
                width: 75,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0.1),
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if(name.text==''||email.text==''){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => CupertinoAlertDialog(
                              title:  Text(
                                AppLocalizations.of(context)?.problem ??  "",
                              ),
                              content:  Text(
                                AppLocalizations.of(context)?.pleaseEnterEmailOrName ??  "",
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:  Text(
                                    AppLocalizations.of(context)?.ok ??  "",
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else{
                          ApiServices.signUpAPi(email.text,name.text).then((success){
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
                                  content: const Text("Email Already Exists"),
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
                              Navigator.pushNamed(context, "botombar");
                            }
                          });
                        }
                        print("object");
                      },
                      child: Transform.rotate(
                          angle: 180 * math.pi / 180,
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ))),
                ),
              ),
            ),
            // Transform.translate(
            //   offset: const Offset(0.0, 15),
            //   child: Align(
            //     alignment: AlignmentDirectional.bottomCenter,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         const Text("Already Have an Account?"),
            //         TextButton(
            //             onPressed: () {
            //               Navigator.pushNamed(context, "SignIn");
            //             },
            //             child: const Text("SignIn Now"))
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
