import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/viewCarModel.dart';

class CustomImage extends StatelessWidget {
  final List<VehicleImages>? images;
  final double height;
  final double width;
  final BoxFit fit;
  int activeindex = 2;
  CustomImage({super.key, 
    this.images,
    this.height = 100.0,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: images?.length,
          itemBuilder:
              (BuildContext context, int index, int realIndex) {
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
                      // color: Colors.white,
                      height: 185,
                      width: 200,
                      child: Transform.translate(
                        offset: const Offset(-5, -10),
                        //padding: const EdgeInsets.only(bottom: 50),
                        child: CachedNetworkImage(
                          width: 200.0,
                          height: 185.0,
                          fit: BoxFit.fitHeight, imageUrl: "http://backend.tamweelcar.com/vehicleImages/${images![index].fileName}",
                        ),
                      )
                    ),
                  ),
                ],
              )
            );
          },
          options: CarouselOptions(
              onPageChanged: (index, reason) async{
                activeindex = index;
              },
              viewportFraction: 1,
              autoPlay: true,
              height: 170),
        ),
        const SizedBox(
          height: 10,
        ),
        AnimatedSmoothIndicator(
          activeIndex: activeindex,
          count: images!.length,
          effect: const ScaleEffect(
              activeDotColor: Color(0xff4263eb),
              dotHeight: 7,
              dotWidth: 7),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}