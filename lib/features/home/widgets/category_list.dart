import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_application_tripmate/widgets/common/section_header.dart';

class CategoryData {
  final String label;
  final String assetsPath;
  final Color backgroundColor;
  final Color iconColor;

  const CategoryData({
    required this.label,
    required this.assetsPath,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  static const List<CategoryData> categoryList = [
    CategoryData(
      label: 'Hotels',
      assetsPath: AppAssets.hotelsCategory,
      backgroundColor: Color(0x146C63FF), // Primary Purple with 8% opacity
      iconColor: AppColors.primaryColor,
    ),
    CategoryData(
      label: 'Flights',
      assetsPath: AppAssets.flightsCategory,
      backgroundColor: Color(0x146C63FF), // Primary Purple with 8% opacity
      iconColor: AppColors.primaryColor,
    ),
    CategoryData(
      label: 'Holidays',
      assetsPath: AppAssets.holidaysCategory,
      backgroundColor: Color(0x146C63FF), // Primary Purple with 8% opacity
      iconColor: AppColors.primaryColor,
    ),
    CategoryData(
      label: 'Activities',
      assetsPath: AppAssets.activitiesCategory,
      backgroundColor: Color(0x146C63FF), // Primary Purple with 8% opacity
      iconColor: AppColors.primaryColor,
    ),
    CategoryData(
      label: 'Cars',
      assetsPath: AppAssets.carsCategory,
      backgroundColor: Color(0x146C63FF), // Primary Purple with 8% opacity
      iconColor: AppColors.primaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Categories',
          onSeeAllTap: () {},
        ),
        SizedBox(height: AppSizes.spacing10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: categoryList.map((category) {
              return Padding(
                padding: EdgeInsets.only(right: AppSizes.spacing20),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(AppSizes.radius16),
                  child: Column(
                    children: [
                      Container(
                        height: AppSizes.spacing56,
                        width: AppSizes.spacing56,
                        decoration: BoxDecoration(
                          color: category.backgroundColor,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radius16,
                          ),
                        ),
                        child: Center(
                          child: AppSvg(
                            assetPath: category.assetsPath,
                            height: AppSizes.icon28,
                            width: AppSizes.icon28,
                            color: category.iconColor,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSizes.spacing8),
                      Text(
                        category.label,
                        style: AppTextStyles.caption.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
