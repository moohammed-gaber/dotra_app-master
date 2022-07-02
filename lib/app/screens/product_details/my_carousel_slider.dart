import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotra/app/globals/models/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCarouselSlider extends StatelessWidget {
  final List<ImageEntity> images;

  const MyCarouselSlider({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            scrollPhysics: BouncingScrollPhysics(),
            viewportFraction: 0.8,
            disableCenter: true,
            autoPlay: true,
            enableInfiniteScroll: true,
            height: 350.0.h),
        items: images.map((image) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Image.network(
                image.getImage,
                fit: BoxFit.cover,
              ));
        }).toList());
  }
}
