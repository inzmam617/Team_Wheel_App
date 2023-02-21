import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Services/apiService.dart';

class VerificationScreen extends StatefulWidget {
  final email;

  const VerificationScreen({Key? key, this.email}) : super(key: key);

  @override
  State<VerificationScreen> createState() =>
      _VerificationScreenState(email: email);
}

class _VerificationScreenState extends State<VerificationScreen> {
  final email;

  _VerificationScreenState({required this.email});

  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  TextEditingController five = TextEditingController();
  TextEditingController six = TextEditingController();
  FocusNode textFirstFocusNode = FocusNode();
  FocusNode textSecondFocusNode = FocusNode();
  FocusNode textThirdFocusNode = FocusNode();
  FocusNode textFourFocusNode = FocusNode();
  FocusNode textFiveFocusNode = FocusNode();
  FocusNode textSixFocusNode = FocusNode();
  String code = "";
  final __isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Text(
                AppLocalizations.of(context)?.verification ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 50,),
          const Text("we've sent 6 digits verification code to your email" ,style: TextStyle(color: Colors.grey),),
          const SizedBox(height: 50,),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.0)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)?.enter_code ?? "",
                        style: const TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _customBox(one,textSecondFocusNode,textFirstFocusNode,),
                            _customBox(two,textThirdFocusNode,textSecondFocusNode),
                            _customBox(three,textFourFocusNode,textThirdFocusNode),
                            _customBox(four,textFiveFocusNode,textFourFocusNode),
                            _customBox(five,textSixFocusNode,textFiveFocusNode),
                            _customBox(six,textSixFocusNode,textSixFocusNode),

                          ],
                        ),
                      ),

                    ),
                    SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(6.0),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                // shape: MaterialStateProperty.all<
                                //     RoundedRectangleBorder>(
                                //   // RoundedRectangleBorder(
                                //   //   borderRadius:
                                //   //       BorderRadius.circular(100),
                                //   // ),
                                // ),
                              ),
                              onPressed: __isLoading ? null : __onSubmit,
                              child: __isLoading
                                  ? Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child:
                                          const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Center(
                                child: Text("Done"),
                              )
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customBox(controller,nextFocusNode,cFocusNode){
    return  Container(

      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 2.0)
          ],
          borderRadius:
          BorderRadius.all(Radius.circular(10))),

      height: 70,
      width: 40,
      child: Center(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: controller,
          style: const TextStyle(fontSize: 30),
          decoration: const InputDecoration(
              contentPadding:
              EdgeInsets.only(top: 0, left: 10),
              border: InputBorder.none),
          onChanged: (_) {
            FocusScope.of(context)
                .requestFocus(nextFocusNode);
          },
          focusNode: cFocusNode,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1)
          ],
        ),
      ),
    );
  }

  final _isLoading = false;
  // void _onSubmit() {
  //
  //   setState(() => _isLoading = true);
  //   Future.delayed(
  //     const Duration(seconds: 2),
  //         () => setState(() => _isLoading = false),
  //   ).then((value) {
  //     final snackBar = SnackBar(
  //       content:  Text(
  //         AppLocalizations.of(context)?.please_wait ?? ""
  //
  //         ,style: TextStyle(color: Colors.white),),
  //       backgroundColor: (Colors.black),
  //       action: SnackBarAction(
  //         label: AppLocalizations.of(context)?.dismiss ?? "",
  //         onPressed: () {
  //         },
  //       ),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //     if(email.text==''){
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) => CupertinoAlertDialog(
  //           title:  Text(
  //             AppLocalizations.of(context)?.problem ??  "",
  //           ),
  //           content:  Text(
  //             AppLocalizations.of(context)?.please_enter_email ??  "",
  //           ),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: const Text("Ok"),
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //     else{
  //       ApiServices.signInAPi(email.text).then((success)async{
  //         if(success=="error"){
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) => CupertinoAlertDialog(
  //               title: const Text("Error Occured"),
  //               content: const Text("Please Try again"),
  //               actions: <Widget>[
  //                 CupertinoDialogAction(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("Ok"),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //         else if(success=="error1"){
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) => CupertinoAlertDialog(
  //               title: const Text("Error Occured"),
  //               content: const Text("Email Not Found"),
  //               actions: <Widget>[
  //                 CupertinoDialogAction(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: const Text("Ok"),
  //                 ),
  //               ],
  //             ),
  //           );
  //
  //         }
  //         else{
  //           final prefs = await SharedPreferences.getInstance();
  //           await prefs.setString('name', success);
  //           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
  //             return const VerificationScreen();
  //           }));
  //           // showDialog(
  //           //     context: context,
  //           //     builder: (BuildContext context) {
  //           //       return StatefulBuilder(
  //           //           builder: (context,setState){
  //           //             return AlertDialog(
  //           //               title:  Text(
  //           //                 AppLocalizations.of(context)?.verification ?? ""
  //           //
  //           //               ),
  //           //               content: Form(
  //           //                 key: _formKey,
  //           //                 child: Column(
  //           //                   mainAxisSize: MainAxisSize.min,
  //           //                   children: <Widget>[
  //           //                     TextFormField(
  //           //                       controller: _otpController,
  //           //                       decoration: const InputDecoration(
  //           //                         labelText: 'OTP',
  //           //                       ),
  //           //                       validator: (value) {
  //           //                         if (value!.isEmpty) {
  //           //                           return 'Enter OTP';
  //           //                         }
  //           //                         return null;
  //           //                       },
  //           //                     ),
  //           //                   ],
  //           //                 ),
  //           //               ),
  //           //               actions: <Widget>[
  //           //                 Transform.translate(
  //           //                   offset: const Offset(0.0, -10),
  //           //                   child: Container(
  //           //                     decoration: BoxDecoration(
  //           //                         color: Colors.white,
  //           //                         borderRadius: BorderRadius.circular(100)),
  //           //                     height: 65,
  //           //                     width: 65,
  //           //                     child: Padding(
  //           //                       padding: const EdgeInsets.all(1),
  //           //                       child: ElevatedButton(
  //           //                           style: ButtonStyle(
  //           //                             elevation: MaterialStateProperty.all(0.1),
  //           //                             backgroundColor: MaterialStateProperty.all(Colors.blue),
  //           //                             shape:
  //           //                             MaterialStateProperty.all<RoundedRectangleBorder>(
  //           //                               RoundedRectangleBorder(
  //           //                                 borderRadius: BorderRadius.circular(100),
  //           //                               ),
  //           //                             ),
  //           //                           ),
  //           //                           onPressed:__isLoading ? null : __onSubmit,
  //           //                           child:__isLoading
  //           //                               ? Container(
  //           //                             width: 24,
  //           //                             height: 24,
  //           //                             padding: const EdgeInsets.all(2.0),
  //           //                             child: const CircularProgressIndicator(
  //           //                               color: Colors.white,
  //           //                               strokeWidth: 3,
  //           //                             ),
  //           //                           ) :Transform.rotate(
  //           //                               angle: 180 * math.pi / 180,
  //           //                               child: const Icon(
  //           //                                 Icons.arrow_back,
  //           //                                 size: 30,
  //           //                               ))),
  //           //                     ),
  //           //                   ),
  //           //                 ),
  //           //               ],
  //           //             );
  //           //           });
  //           //     });
  //           setState(() {
  //
  //           });
  //         }
  //       });
  //     }
  //   });
  //
  // }


  void __onSubmit() {
    print(one.text + two.text + three.text + four.text);
    code = one.text + two.text + three.text + four.text + five.text + six.text;
    print("${code}thisis th");
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
     // if (_formKey.currentState!.validate()) {
        ApiServices.verifyOpt(email, code).then((value) {
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
          //  Navigator.of(context).pop();
          }
        });

     // }

  }
}
