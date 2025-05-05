
import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorsManager.textIconColorGray,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.textIconColorGray,
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 1,
                    color: ColorsManager.textIconColorGray,
                  ),
                ),
              ],
            );
  }
}