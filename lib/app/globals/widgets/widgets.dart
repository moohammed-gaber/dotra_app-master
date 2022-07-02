import 'package:dotra/res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalWidgets {
  bool x = false;

  static Widget image(bool condition, double width, double height, String url) =>
      condition
          ? Image.asset(
              Res.logo,
              height: height.h,
              width: width.w,
              fit: BoxFit.cover,
            )
          : Image.network(
              (url),
              height: height.h,
              width: width.w,
              fit: BoxFit.cover,
            );
}
// حاجه غريبه والله
// مفيش فايده يبني والله

//سيبها كدا وخلاص مش لازم تختصر
// انا عشان الحوار دا هستخدمه فى كذا حته كمان
// مش هنا بس
