import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String) onChanged;
  final String initialValue;
  final bool eye;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.keyboardType,
      required this.obscureText,
      required this.onChanged,
      required this.initialValue,
      required this.eye});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      onChanged: onChanged,
      cursorHeight: 15.h,
      textAlignVertical: TextAlignVertical.center,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autocorrect: false,
      obscureText: obscureText,
      cursorColor: Theme.of(context).disabledColor,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 10.w, top: 12.h, right: 10.w, bottom: 12.h),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Icon(
              eye
                  ? obscureText
                      ? Iconsax.eye
                      : Iconsax.eye_slash
                  : null,
              size: 18.h,
              color: Theme.of(context).iconTheme.color!.withOpacity(.5),
            ),
          ),
          constraints: BoxConstraints(maxWidth: 300.w, maxHeight: 40.h),
          fillColor: Theme.of(context).iconTheme.color!.withOpacity(.05),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  // BorderSide(color: Theme.of(context).iconTheme.color!),
                  BorderSide.none),
          filled: true),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool outlined;
  const AuthButton(
      {super.key,
      required this.label,
      required this.onTap,
      required this.outlined});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 300.w,
        decoration: BoxDecoration(
            color:
                outlined ? Colors.transparent : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: outlined
                    ? Theme.of(context).iconTheme.color!.withOpacity(.1)
                    : Colors.transparent)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: outlined
                    ? Theme.of(context).iconTheme.color
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}

class AuthButtonSmall extends StatelessWidget {
  final String label;
  final void Function() onTap;
  final bool outlined;
  const AuthButtonSmall({
    super.key,
    required this.label,
    required this.onTap,
    required this.outlined,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
        decoration: BoxDecoration(
            color:
                outlined ? Colors.transparent : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: outlined
                    ? Theme.of(context).iconTheme.color!.withOpacity(.1)
                    : Colors.transparent)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: outlined
                    ? Theme.of(context).iconTheme.color
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}

class PaddedBox extends StatelessWidget {
  final String label;
  const PaddedBox({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color!.withOpacity(.04),
          borderRadius: BorderRadius.circular(7)),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
