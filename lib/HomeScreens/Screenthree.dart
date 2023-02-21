import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Drawer/drawer.dart';
import '../Services/apiService.dart';
import '../model/viewCarModel.dart';
import 'ScreenTwo.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class screenthree extends StatefulWidget {
  final String balance;
  const screenthree({super.key, required this.balance});

  @override
  State<screenthree> createState() => _screenthreeState(balance_: balance);
}

class _screenthreeState extends State<screenthree> {
  final images = [
    "assets/carhnew.png",
    "assets/carhnew.png",
    "assets/carhnew.png",
    "assets/carhnew.png"
  ];
  int activeindex = 2;
  final balance_;
  bool order=false;
  @override
  void initState() {
    load("assets/triangle.png").then((image) {
      setState(() {
        overlayimage = image;
      });
    });
    super.initState();
    setState(() {
      initialize();
    });
  }
  // List<DropdownMenuItem<String>> dropdownItems=[];
  late viewCarModel vehicles=viewCarModel();
  List<String> makeNames=['Nissan','Toyota','Honda','نظيفه','Kia','Hyundai','حاله جيده','Ford Cars','Honda Alpha','Tesla','Mitsubish'];
  //List<String> makeNames=['0','1'];
  String _dropdownValue = 'Nissan';
  void initialize()async{
    ApiServices.LoadVehicle(balance_).then((value) {
      setState(() {
        vehicles=value;
      });
      setState(() {

      });
    });
  }
  bool check1=false,check2=false,check3=false;
  void sort(){
    if(check1==true){
      setState(() {
        vehicles.data!.sort((b, a) => a.totalPrice!.compareTo(b.totalPrice as num));
      });
      setState(() {
      });
    }
    if(check2==true){
      setState(() {
        vehicles.data!.sort((a, b) => a.totalPrice!.compareTo(b.totalPrice as num));
      });
      setState(() {
      });
    }

  }
  int count=0;
  _screenthreeState({required this.balance_});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context,setState){
                      return AlertDialog(
                        title: const Text("Filter"),
                        content:SizedBox(
                          height: 180,
                          width: 180,
                          child: Column(
                            children: [
                              const SizedBox(height: 10,),
                              DropdownButton<String>(
                                hint: const Text("Make Names"),
                                value: _dropdownValue,
                                isExpanded: true,
                                items:makeNames.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? selectedvalue) async{
                                  setState(() {
                                    initialize();
                                    _dropdownValue = selectedvalue.toString();
                                    check3=true;
                                  });
                                },
                              ),
                              const SizedBox(height: 30,),
                              SizedBox(
                                height: 20,
                                child: GestureDetector(
                                  onTap:(){
                                    setState(() {

                                    });
                                    //temp=false;
                                    check1 = true;
                                    check2 = false;
                                    setState(() {

                                    });
                                  },
                                  child: Row(
                                    children: [
                                    check1
                                    ? const Icon(
                                    Icons.check_circle_sharp,
                                    color: Colors.blue,
                                  ): const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.blue,
                                    ),
                                      const SizedBox(width: 10,),
                                      const Text("High to Low",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30,),
                              SizedBox(
                                height: 20,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {

                                    });
                                    //temp=true;
                                    check2 = true;
                                    check1 = false;
                                    setState(() {

                                    });
                                  },
                                  child: Row(
                                    children: [
                                      check2
                                          ? const Icon(
                                        Icons.check_circle_sharp,
                                        color: Colors.blue,
                                      ): const Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 15,),
                                      const Text("Low to High",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        actions: <Widget>[
                          Theme(
                            data: Theme.of(context).copyWith(
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  )
                              ),
                            ),
                            child: ElevatedButton(
                              child: const Text("Reset", style: TextStyle(color: Colors.white),),
                              onPressed: () async{
                                setState(() {
                                  check1=false;
                                  check2=false;
                                  check3=false;
                                  initialize();
                                  Navigator.pop(context);
                                });

                              },
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              elevatedButtonTheme: ElevatedButtonThemeData(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  )
                              ),
                            ),
                            child: ElevatedButton(
                              child: const Text("Apply", style: TextStyle(color: Colors.white),),
                              onPressed: () {
                                sort();
                                setState(() {
                                  Navigator.pop(context);
                                  final snackBar = SnackBar(
                                    duration: const Duration(seconds: 2),
                                    content: const Text('Loading...',style: TextStyle(color: Colors.white),),
                                    backgroundColor: (Colors.black),
                                    action: SnackBarAction(
                                      label: 'dismiss',
                                      onPressed: () {
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar).setState;
                                });

                              },
                            ),
                          ),
                        ],
                      );
                    });
                  },
                );
              },
              child: Container(
                height: 25,
                width: 30,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5.0)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Icon(Icons.filter_list_alt,color: Colors.black,)
              ),
            ),
          )
        ],
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
      body:Container(
        child: vehicles.data==null?
        const Center(child: CircularProgressIndicator(),):
        ListView.builder(
          itemCount: vehicles.data?.length,
          itemBuilder: (context, index) {
            List<VehicleImages>? abc=vehicles.data![index].vehicleImages;
            if(vehicles!=null){
              if( check3==true&&vehicles.data![index].makeName==_dropdownValue){
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Color(0xff4263eb), blurRadius: 5.0)
                        ],
                        color: Color(0xffefefff),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 1.1)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          height: 190,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, left: 10),
                                          child: Text(
                                            "${vehicles.data![index].makeName}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4263eb),
                                                fontSize: 18),
                                          ),
                                        ),
                                        Text(
                                          "${vehicles.data![index].year}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 20, bottom: 20),
                                      child: Container(
                                        width: 18,
                                        height: 23,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => screenTwo(monthlyInstallment: "${vehicles.data![index].totalPrice}",vehicles: vehicles.data![index],)));
                                    },
                                    child: Column(
                                      children: [
                                        CarouselSlider.builder(
                                          itemCount: abc!.length,
                                          itemBuilder: (BuildContext context,
                                              int index, int realIndex) {
                                            //final url = images[index];

                                            return SizedBox(
                                              width:
                                              MediaQuery.of(context).size.width,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover, imageUrl: "http://backend.tamweelcar.com/vehicleImages/${abc[index].fileName}",
                                              ),
                                            );
                                          },
                                          options: CarouselOptions(
                                              onPageChanged: (index, reason) =>
                                                  setState(() {
                                                    activeindex = index;
                                                  }),
                                              viewportFraction: 1,
                                              autoPlay: true,
                                              height: 120),
                                        ),
                                        AnimatedSmoothIndicator(
                                          activeIndex: activeindex,
                                          count: abc.length,
                                          effect: const ScaleEffect(
                                              activeDotColor: Color(0xff4263eb),
                                              dotHeight: 7,
                                              dotWidth: 7),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                   Text(
                                     AppLocalizations.of(context)?.total_price ?? "",
                                    style: const TextStyle(

                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${vehicles.data![index].totalPrice}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4263eb)),
                                      ),
                                      const SizedBox(width: 2,),
                                      const Text("rs",style: TextStyle(color: Colors.grey,fontSize: 12),)
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   Text(
                                    AppLocalizations.of(context)?.monthly_installment ?? "",
                                    style: const TextStyle(

                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${vehicles.data![index].monthlyInstallments}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4263eb)),
                                      ),
                                      const SizedBox(width: 2,),
                                      const Text("rs",style: TextStyle(color: Colors.grey,fontSize: 12),)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if(check3==false){
                return Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    height: 250,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Color(0xff4263eb), blurRadius: 5.0)
                        ],
                        color: Color(0xffefefff),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 1.1)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: Colors.white,
                          ),
                          height: 190,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, left: 10),
                                          child: Text(
                                            "${vehicles.data![index].makeName}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff4263eb),
                                                fontSize: 18),
                                          ),
                                        ),
                                        Text(
                                          "${vehicles.data![index].year}",
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 20, bottom: 20),
                                      child: Container(
                                        width: 18,
                                        height: 23,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(8)),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => screenTwo(monthlyInstallment: "${vehicles.data![index].totalPrice}",vehicles: vehicles.data![index],)));
                                    },
                                    child: Column(
                                      children: [
                                        CarouselSlider.builder(
                                          itemCount: abc!.length,
                                          itemBuilder: (BuildContext context,
                                              int index, int realIndex) {
                                            //final url = images[index];

                                            return SizedBox(
                                              width:
                                              MediaQuery.of(context).size.width,
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover, imageUrl: "http://backend.tamweelcar.com/vehicleImages/${abc[index].fileName}",
                                              ),
                                            );
                                          },
                                          options: CarouselOptions(
                                              onPageChanged: (index, reason) =>
                                                  setState(() {
                                                    activeindex = index;
                                                  }),
                                              viewportFraction: 1,
                                              autoPlay: true,
                                              height: 120),
                                        ),
                                        AnimatedSmoothIndicator(
                                          activeIndex: activeindex,
                                          count: abc.length,
                                          effect: const ScaleEffect(
                                              activeDotColor: Color(0xff4263eb),
                                              dotHeight: 7,
                                              dotWidth: 7),
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                    "Total Price",
                                    style: TextStyle(

                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${vehicles.data![index].totalPrice}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4263eb)),
                                      ),
                                      const SizedBox(width: 2,),
                                      const Text("rs",style: TextStyle(color: Colors.grey,fontSize: 12),)
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Monthly Installment",
                                    style: TextStyle(

                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${vehicles.data![index].monthlyInstallments}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff4263eb)),
                                      ),
                                      const SizedBox(width: 2,),
                                      const Text("rs",style: TextStyle(color: Colors.grey,fontSize: 12),)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              else{
                return Container();
              }
            }
            else{
              return const Center(
                child: Text("Result not found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              );
            }
          },
        )
      )
    );
  }
}
