// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:teamwheelapp/model/viewCarModel.dart';
//
// import '../Components/customImage.dart';
// import '../Drawer/drawer.dart';
// import '../Services/apiService.dart';
// import 'ScreenTwo.dart';
//
// class viewCar extends StatefulWidget {
//   final String balance;
//   viewCar({required this.balance});
//
//   @override
//   State<viewCar> createState() => _viewCarState(balance_: this.balance);
// }
//
// class _viewCarState extends State<viewCar> {
//   final balance_;
//   _viewCarState({required this.balance_});
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(builder: (context) {
//           return IconButton(
//               onPressed: () {
//                 Scaffold.of(context).openDrawer();
//               },
//               icon: Image.asset("assets/more.png"));
//         }),
//         //automaticallyImplyLeading: false,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       backgroundColor: Color(0xfff9f9ff),
//       drawer: const Drawer(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
//         ),
//         //width: (width)/3,
//         child: drawer(),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text("Your renaining balance is: ${widget.balance}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
//               ],
//             ),
//             Flexible(child: FutureBuilder<viewCarModel>(
//               future: ApiServices.LoadVehicle(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.data?.length,
//                     itemBuilder: (context, index) {
//                       List<VehicleImages>? abc=snapshot.data?.data![index].vehicleImages;
//                       return Stack(
//                         children: [
//                           Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 40),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                                   children: [
//                                     // _PostHeader(),
//                                     //Padding(padding: const EdgeInsets.symmetric(vertical: 8),),
//                                     Container(
//                                       decoration:BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(20),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.black.withOpacity(0.3),
//                                             blurRadius: 1,
//                                             offset: const Offset(0,0.2),
//                                           ),
//                                         ],
//                                       ),
//                                       child:Column(
//                                         children: [
//                                           GestureDetector(
//                                             onTap: (){
//                                               Navigator.of(context).push(MaterialPageRoute(builder: (context) => screenTwo(monthlyInstallment: "${snapshot.data!.data![index].totalPrice}",)));
//                                             },
//                                             child: ClipRRect(
//                                               borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(8.0),
//                                                 topRight: Radius.circular(8.0),
//                                                 bottomRight: Radius.circular(8.0),
//                                                 bottomLeft: Radius.circular(8.0),
//                                               ),
//                                               child: CustomImage(
//                                                 images: abc,
//                                                 height: 150.0,
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
//                                     Row(
//                                       //mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             // crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].modelName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.end,
//                                             //crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].makeName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
//                                     SizedBox(height: 5,),
//                                     Row(
//                                       //mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             // crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].year}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.end,
//                                             //crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].bodyTypeName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.end,
//                                             //crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].engineTypeName}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Padding(padding: const EdgeInsets.symmetric(vertical: 4),),
//                                     SizedBox(height: 5,),
//                                     Row(
//                                       //mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             // crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].totalPrice}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//                                             ],
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex:1,
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.end,
//                                             //crossAxisAlignment: CrossAxisAlignment.end,
//                                             children: [
//                                               Text("${snapshot.data!.data![index].monthlyInstallments}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text("${snapshot.error}");
//                 }
//                 return CircularProgressIndicator();
//               },
//             ))
//           ],
//         ),
//       )
//     );
//   }
//
// }
//
