import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waythru/ui/widgets/auth.dart';

class VGap extends StatelessWidget {
  final double height;
  const VGap({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HGap extends StatelessWidget {
  final double width;
  const HGap({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class Erroror extends StatelessWidget {
  final String error;
  final void Function() onTap;
  const Erroror({super.key, required this.error, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red, width: 2),
                color: Colors.red.withOpacity(.5)),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.sp),
                ),
                VGap(height: 10.h),
                Text(
                  error,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.w),
            child: SizedBox(
              width: 180.w,
              child: AuthButton(label: 'Go Back', onTap: onTap, outlined: false)),
          )
        ],
      ),
    ));
  }
}
