
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/styles.dart';

class DataRowWidget extends StatelessWidget {
  final String label;
  final String value;

  const DataRowWidget({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Styles.styleText14BlackColofontJosefinSans),
          Text(value, style: Styles.styleText14BlackColofontJosefinSans),
        ],
      ),
    );
  }
}
