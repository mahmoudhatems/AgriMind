import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IconPosition { left, right }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.textStyle,
    this.borderColor,
    required this.borderRadius,
     this.icon,
    this.iconColor,
    this.iconTextSpacing = 12.0,
    this.iconPosition = IconPosition.left, // Default icon position
  });

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final TextStyle textStyle;
  final Color? borderColor;
  final BorderRadius borderRadius;
  final Widget ? icon;
  final Color? iconColor;
  final double iconTextSpacing;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    // Build the icon widget based on type
    Widget builtIcon = icon is Icon
        ? Icon(
            (icon as Icon).icon,
            color: iconColor ?? (icon as Icon).color,
            size: 30.sp,
          )
        : SizedBox(
            width: 28.w,
            height: 28.h,
            child: icon,
          );

    return Material(
      borderRadius: borderRadius,
      color: backgroundColor,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            border:
                borderColor != null ? Border.all(color: borderColor!) : null,
            borderRadius: borderRadius,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
      
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Text(
                    text,
                    style: textStyle,
                  ),
                ),
                if (iconPosition == IconPosition.left)
                  Positioned(
                    left: 5,
                    child: builtIcon,
                  )
                else
                  Positioned(
                    right: 0,
                    child: builtIcon,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
