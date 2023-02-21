import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:teamwheelapp/HomeScreens/Screenthree.dart';
import '../Drawer/drawer.dart';
import '../Services/apiService.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class screenOne extends StatefulWidget {
  const screenOne({Key? key}) : super(key: key);

  @override
  State<screenOne> createState() => _screenOneState();
}

bool isAnimating = true;

enum ButtonState { init, submitting, completed }

class _screenOneState extends State<screenOne> {
  final images = [
    "assets/Vector.png",
    "assets/Vector.png",
    "assets/Vector.png",
    "assets/Vector.png"
  ];
  int activeindex = 2;
  String dropdownValue = "English";
  bool isDisabledsal = true;
  bool isDisabledlease = false;
  bool isDisabledPlone = false;
  bool isDisabledMlone = false;
  bool isDisabledClimit = false;
  TextEditingController salary = TextEditingController(text: "0");
  TextEditingController auto_lease = TextEditingController(text: "0");
  TextEditingController personal_loan = TextEditingController(text: "0");
  TextEditingController mortgage_loan = TextEditingController(text: "0");
  TextEditingController creditcard_limit = TextEditingController(text: "0");
  String name = " ";

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name').toString();
  }

  ButtonState state = ButtonState.init;

  @override
  Widget build(BuildContext context) {
    final buttonWidth = MediaQuery.of(context).size.width;
    final isInit = isAnimating || state == ButtonState.init;
    final isDone = state == ButtonState.completed;
    return Scaffold(
        extendBody: true,
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
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xfff9f9ff),
      drawer: const Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
        //width: (width)/3,
        child: drawer(),
      ),
      body: Stack(children: [
        Transform.translate(
          offset: const Offset(-10, -90),
          child: Image.asset(
            "assets/Ellipse 16.png",
            color: Colors.blue.withOpacity(0.1),
          ),
        ),
        Transform.translate(
          offset: const Offset(-35, -90),
          child: Image.asset("assets/Ellipse 14.png",
              color: Colors.grey.withOpacity(0.1)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)?.message ?? "",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        " ${name.toUpperCase()}",
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 28),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 20, right: 10),
                    child: Column(
                      children: [
                        CarouselSlider.builder(
                          itemCount: images.length,
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            final url = images[index];

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2)
                                  ],
                                  //color: Colors.black,
                                  image: DecorationImage(
                                      image: AssetImage(url), fit: BoxFit.fill),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Toyota Corolla ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          Row(
                                            children: [
                                              const Text(
                                                "2022",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                height: 10,
                                                color: Colors.white,
                                                width: 1.5,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              const Text("Sedan",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              Container(
                                                height: 10,
                                                color: Colors.white,
                                                width: 1.5,
                                              ),
                                              const SizedBox(
                                                width: 3,
                                              ),
                                              const Text("Petrol",
                                                  style: TextStyle(
                                                      color: Colors.white))
                                            ],
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              // color: Colors.white,
                                              height: 120,
                                              width: 180,
                                              child: Center(
                                                child: Transform.translate(
                                                  offset: const Offset(-5, -10),
                                                  //padding: const EdgeInsets.only(bottom: 50),
                                                  child: Image.asset(
                                                    "assets/carpng.png",
                                                    width: 200.0,
                                                    height: 185.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //SizedBox(width: 100,),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 55),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                          ?.monthly_installment ??
                                                      "",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "SAR",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      "1700",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .indigo[600],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              onPageChanged: (index, reason) => setState(() {
                                    activeindex = index;
                                  }),
                              viewportFraction: 1,
                              autoPlay: true,
                              height: 170),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: activeindex,
                          count: images.length,
                          effect: const ScaleEffect(
                              activeDotColor: Color(0xff4263eb),
                              dotHeight: 7,
                              dotWidth: 7),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                _customBar(AppLocalizations.of(context)?.salary ?? "", salary),
                const SizedBox(
                  height: 10,
                ),
                _customBar(
                    AppLocalizations.of(context)?.autoLease ?? "", auto_lease),
                const SizedBox(
                  height: 10,
                ),
                _customBar(AppLocalizations.of(context)?.personal_Loan ?? "",
                    personal_loan),
                const SizedBox(
                  height: 10,
                ),
                _customBar(AppLocalizations.of(context)?.mortgage_lone ?? "",
                    mortgage_loan),
                const SizedBox(
                  height: 10,
                ),
                _customBar(
                    AppLocalizations.of(context)?.credit_card_limit ?? "",
                    creditcard_limit),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: 180,
                    height: 40,
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        onEnd: () => setState(() {
                              isAnimating = !isAnimating;
                            }),
                        width: state == ButtonState.init ? buttonWidth : 100,
                        height: 60,
                        // If Button State is Submiting or Completed  show 'buttonCircular' widget as below
                        child: isInit
                            ? buildButton()
                            : circularContainer(isDone))),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _customBar(text, controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                //AppLocalizations.of(context)?.salary ??  "",
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const Material(
                elevation: 5,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Material(
            elevation: 5,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.deepPurpleAccent.withOpacity(0.2),
                              offset: const Offset(0.0, 0.45))
                        ]),
                    child: TextFormField(
                      controller: controller,
                      //enabled: isDisabledsal,
                      maxLength: 5,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          hintText: "0.0",
                          counterText: "",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10,bottom: 5)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            foregroundColor: const Color(0xff4263eb),
            backgroundColor: const Color(0xff4263eb)),
        onPressed: () async {
          setState(() {
            state = ButtonState.submitting;
          });
          ApiServices.installmentResult(salary.text, auto_lease.text,
                  personal_loan.text, mortgage_loan.text, creditcard_limit.text)
              .then((success) {
            print("success:$success");
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Your remaining installment amount is',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          color: const Color(0xfff8f8fe),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "SAR",
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xff4263eb)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(success,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),

                        const Text("This is an approximate calculation, for ",
                            style: TextStyle(color: Colors.grey)),
                        const Text("installment balance you should contact ",
                            style: TextStyle(color: Colors.grey)),
                        const Text("your bank ",
                            style: TextStyle(color: Colors.grey)),
                        const SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //    installment balance you should contact your bank",style: TextStyle(color: Colors.grey),),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff4263eb))),
                            child: const Text('VIEW VEHICLES'),
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => viewCar(balance: success.toString(),)));
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => screenthree(
                                        balance: success.toString(),
                                      )));
                            }),
                      ],
                    ),
                  ),
                );
              },
            );
          });
          //await 2 sec // you need to implement your server response here.
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            state = ButtonState.completed;
          });
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            state = ButtonState.init;
          });
        },
        child: const Text(
          'Calculate',
          style: TextStyle(color: Colors.white),
        ),
      );

  Widget circularContainer(bool done) {
    final color = done ? const Color(0xff4263eb) : const Color(0xff4263eb);
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: done
            ? const Icon(Icons.done, size: 50, color: Colors.white)
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
