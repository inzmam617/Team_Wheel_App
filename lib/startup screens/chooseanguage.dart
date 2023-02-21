import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../l10n/l10n.dart';
import '../provider/local_provdier.dart';

class chooseanguage extends StatefulWidget {
  const chooseanguage({Key? key}) : super(key: key);

  @override
  State<chooseanguage> createState() => _chooseanguageState();
}

class _chooseanguageState extends State<chooseanguage> {
  String dropdownValue = "English";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    final locale = provider.local;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // DropdownButtonHideUnderline(
          //   child: DropdownButton(
          //     value: locale,
          //     icon: Container(width: 12),
          //     items: L10n.all.map(
          //           (locale) {
          //         final flag = L10n.getFlag(locale.languageCode);
          //
          //         return DropdownMenuItem(
          //           value: locale,
          //           onTap: () {
          //             final provider =
          //             Provider.of<LocalProvider>(context, listen: false);
          //
          //             provider.setLocale(locale);
          //           },
          //           child: Center(
          //             child: Text(
          //               flag,
          //               style: const TextStyle(fontSize: 32,color: Colors.black),
          //             ),
          //           ),
          //         );
          //       },
          //     ).toList(),
          //     onChanged: (_) {},
          //   ),
          // ),
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
              height: 180,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0
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
                        //"Choose Language",
                        AppLocalizations.of(context)?.choose_language ?? "",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffff0f0f0),
                            borderRadius: BorderRadius.circular(8)),
                        width: MediaQuery.of(context).size.width,
                        child:  DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: locale,
                            icon: Container(width: 12),
                            items: L10n.all.map(
                                  (locale) {
                                final flag = L10n.getCode(locale.languageCode);

                                return DropdownMenuItem(
                                  value: locale,
                                  onTap: () {
                                    final provider =
                                    Provider.of<LocalProvider>(context, listen: false);

                                    provider.setLocale(locale);
                                  },
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        flag,
                                        style: const TextStyle(fontSize: 20,color: Colors.black),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                        // DropdownButtonFormField<String>(
                        //   value: dropdownValue,
                        //   decoration: const InputDecoration(
                        //     border: InputBorder.none,
                        //       disabledBorder: InputBorder.none,
                        //       enabledBorder: InputBorder.none),
                        //   items:
                        //   const [
                        //     DropdownMenuItem(
                        //         value: "English",
                        //         child: Padding(
                        //           padding: EdgeInsets.only(left: 10),
                        //           child: Text("English"),
                        //         )),
                        //     DropdownMenuItem(
                        //         value: "Arabic",
                        //         child: Padding(
                        //           padding: EdgeInsets.only(left: 10),
                        //           child: Text("Arabic"),
                        //         ))
                        //   ]
                        //   ,
                        //   onChanged: (String? value) {
                        //     print(value);
                        //     dropdownValue = value!;
                        //     //  print(value);
                        //   },
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(2.0),
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: _isLoading ? null : _onSubmit,
                            child: _isLoading
                                ? Container(
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(2.0),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            ) :const Center(
                              child: Text( "Next",style: TextStyle(color: Colors.white),),
                            )
                        ),
                      ),
                    )
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(100)),
                    //   child: IconButton(
                    //    // padding: const EdgeInsets.all(10),
                    //     onPressed: () {  },
                    //     icon: Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.blue,
                    //           borderRadius: BorderRadius.circular(100)),
                    //       child: const Icon(
                    //         Icons.arrow_right_alt,
                    //         color: Colors.white,
                    //         size: 50,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //
                    //     //Navigator.popAndPushNamed(context, 'SignIn');
                    //   },
                    //   child: Transform.translate(
                    //     offset: const Offset(0, 45),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(100)),
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //               color: Colors.blue,
                    //               borderRadius: BorderRadius.circular(100)),
                    //           child: const Icon(
                    //             Icons.arrow_right_alt,
                    //             color: Colors.white,
                    //             size: 50,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: SizedBox(
          //     width: 100,
          //     child: ElevatedButton(
          //         style: ButtonStyle(
          //           elevation: MaterialStateProperty.all(2.0),
          //           backgroundColor: MaterialStateProperty.all(Colors.blue),
          //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //             RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //           ),
          //         ),
          //         onPressed: _isLoading ? null : _onSubmit,
          //         child: _isLoading
          //             ? Container(
          //           width: 24,
          //           height: 24,
          //           padding: const EdgeInsets.all(2.0),
          //           child: const CircularProgressIndicator(
          //             color: Colors.white,
          //             strokeWidth: 3,
          //           ),
          //         ) :Center(
          //           child: Text( "Log In",style: TextStyle(color: Colors.white),),
          //         )
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  var _isLoading = false;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
          () => setState(() => _isLoading = false),
    ).then((value) {
      Navigator.pushNamed(context, "SignIn");
    });

  }

}
