import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  static final defaultTextStyle = TextStyle(fontSize: 14.sp);

  static final emptyHistory = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
  );

  static final headline = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
  );
}
