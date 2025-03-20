import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? profilePreviewContent;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.profilePreviewContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsManager.realWhiteColor,
      elevation: 0,
      leading: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.r, horizontal: 8.0.r),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(StringManager.appIcon, width: 12.w, height: 12.h,)),
      ),
      title: Text(
        title,
        style:Styles.titlesemiBoldText24ButomfontJosefinSans
      ),
      centerTitle: true,
      actions: [
        ProfilePreview(
          profilePreviewContent: profilePreviewContent,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class ProfilePreview extends StatefulWidget {
  final Widget? profilePreviewContent;

  const ProfilePreview({Key? key, this.profilePreviewContent})
      : super(key: key);

  @override
  State<ProfilePreview> createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  bool _isPreviewVisible = false;

  void _togglePreview() {
    setState(() {
      _isPreviewVisible = !_isPreviewVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: _togglePreview,
          child: Padding(
            padding: EdgeInsets.all(8.0.r),
            child: CircleAvatar(
              backgroundImage: AssetImage(StringManager.vector),
              radius: 30.r,
            ),
          ),
        ),
        if (_isPreviewVisible)
          Positioned(
            top: 56.h,
            right: 8.w,
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => setState(() {
                  _isPreviewVisible = false;
                }),
                child: Container(
                  width: 200.w,
                  padding: EdgeInsets.all(12.0.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: widget.profilePreviewContent ??
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mahmoud Hatem',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.textIconColorGray,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'View Profile',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorsManager.textIconColorGray,
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
