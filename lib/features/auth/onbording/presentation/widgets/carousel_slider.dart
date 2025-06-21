import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/strings.dart';
import 'package:happyfarm/core/utils/styles.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> sliderData = [
    {
      'image': StringManager.peasantToolsImage,
      'description': 'Smart Farming, Smarter Future!',
    },
    {
      'image': StringManager.cropSelectionImage,
      'description': 'Grow More, Waste Less, Live Smart.',
    },
    {
      'image': StringManager.cultivatingImage,
      'description': 'Innovating Agriculture, One Smart Step at a Time.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            aspectRatio: 3 / 2,
            height: 330.h,
            autoPlay: true,
            enlargeCenterPage: false,
            autoPlayInterval: const Duration(seconds: 3),
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: true ,
          
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: sliderData.map((banner) {
            return Builder(
              builder: (BuildContext context) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        banner['image'],
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 230.h,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.r),
                      child: Text(
                        banner['description'],
                        textAlign: TextAlign.center,
                        style: Styles.stylesemiBoldText18ButomfontJosefinSans,
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 20.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: sliderData.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentIndex == entry.key ? 12.0 : 8.0,
                  height: _currentIndex == entry.key ? 12.0 : 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? ColorsManager.greenColor
                        : ColorsManager.textIconColorGray,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
