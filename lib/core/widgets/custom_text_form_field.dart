import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,required this.hintText,required this.keyboardType, this.controller, this.suffexIcon});

  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final Widget? suffexIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
        keyboardType: keyboardType ,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          suffixIcon: suffexIcon,
          hintText: hintText,
          hintStyle: Styles.styleNormalText14GrayfontJosefinSans
              .copyWith(fontWeight: FontWeight.w500,color: ColorsManager.textIconColor),
          filled: true,
          fillColor: ColorsManager.textFieldColor,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          errorBorder: buildBorder().copyWith(
            borderSide: BorderSide(
              color: ColorsManager.errorColor,
              width: 1.0.w,
            ),
          ),
        ));
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0.r),
    borderSide:
        BorderSide(color: ColorsManager.textFilledFormColor, width: .3.w),
  );
}
