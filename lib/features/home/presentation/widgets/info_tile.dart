import 'package:flutter/material.dart';
import 'package:happyfarm/core/utils/colors.dart';
import 'package:happyfarm/core/utils/styles.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final Color? backgroundColor;

  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
   // final screenHeight = MediaQuery.of(context).size.height;
    
    // Define breakpoints
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;
    final isMobile = screenWidth < 768;
    
    // Responsive dimensions
    double getResponsiveWidth() {
      if (isDesktop) return screenWidth * 0.12; // 12% of screen width
      if (isTablet) return screenWidth * 0.18;  // 18% of screen width
      return screenWidth * 0.42; // 42% of screen width for mobile
    }
    
    double getResponsivePadding() {
      if (isDesktop) return 24.0;
      if (isTablet) return 20.0;
      return 14.0;
    }
    
    double getResponsiveIconSize() {
      if (isDesktop) return 34.0;
      if (isTablet) return 32.0;
      return 30.0;
    }
    
    double getResponsiveIconPadding() {
      if (isDesktop) return 14.0;
      if (isTablet) return 12.0;
      return 10.0;
    }
    
    double getResponsiveBorderRadius() {
      if (isDesktop) return 24.0;
      if (isTablet) return 20.0;
      return 16.0;
    }
    
    double getResponsiveLabelFontSize() {
      if (isDesktop) return 18.0;
      if (isTablet) return 16.0;
      return 15.0;
    }
    
    double getResponsiveValueFontSize() {
      if (isDesktop) return 20.0;
      if (isTablet) return 18.0;
      return 18.0;
    }
    
    double getResponsiveSpacing() {
      if (isDesktop) return 20.0;
      if (isTablet) return 16.0;
      return 10.0;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate responsive width with constraints
        final maxWidth = constraints.maxWidth;
        final calculatedWidth = getResponsiveWidth();
        final finalWidth = maxWidth < calculatedWidth ? maxWidth : calculatedWidth;
        
        return Container(
          width: finalWidth,
          constraints: BoxConstraints(
            minWidth: isMobile ? 120.0 : 140.0,
            maxWidth: isDesktop ? 200.0 : (isTablet ? 180.0 : 160.0),
            minHeight: isMobile ? 120.0 : 140.0,
          ),
          padding: EdgeInsets.all(getResponsivePadding()),
          decoration: BoxDecoration(
            color: backgroundColor ?? ColorsManager.realWhiteColor,
            borderRadius: BorderRadius.circular(getResponsiveBorderRadius()),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: isDesktop ? 12 : (isTablet ? 10 : 8),
                offset: Offset(0, isDesktop ? 4 : (isTablet ? 3 : 2)),
                spreadRadius: 0,
              ),
            ],
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.08),
              width: isDesktop ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon container
              Flexible(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(getResponsiveIconPadding()),
                
                 
                  child: Icon(
                    icon,
                    size: getResponsiveIconSize(),
                    color: iconColor ?? ColorsManager.mainBlueGreen,
                  ),
                ),
              ),
              
              SizedBox(height: getResponsiveSpacing() * 0.8),
              
              // Label text
              Flexible(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                      fontSize: getResponsiveLabelFontSize(),
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: isMobile ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              
              SizedBox(height: getResponsiveSpacing() * 0.3),
              
              // Value text
              Flexible(
                flex: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: Styles.styleText14BlackColofontJosefinSans.copyWith(
                      fontSize: getResponsiveValueFontSize(),
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ResponsiveInfoGrid extends StatelessWidget {
  final List<InfoTile> tiles;
  final double spacing;
  final EdgeInsetsGeometry? padding;

  const ResponsiveInfoGrid({
    super.key,
    required this.tiles,
    this.spacing = 16.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Determine grid columns based on screen size
    int getCrossAxisCount() {
      if (screenWidth >= 1200) return 6; // Large desktop
      if (screenWidth >= 1024) return 4; // Desktop
      if (screenWidth >= 768) return 3;  // Tablet
      if (screenWidth >= 480) return 2;  // Large mobile
      return 2; // Small mobile
    }
    
    return Padding(
      padding: padding ?? EdgeInsets.all(spacing),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(),
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: screenWidth >= 768 ? 0.9 : 0.85,
        ),
        itemCount: tiles.length,
        itemBuilder: (context, index) => tiles[index],
      ),
    );
  }
}