import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/features/home/widgets/category_list.dart';
import 'package:flutter_application_tripmate/features/home/widgets/destination_card.dart';
import 'package:flutter_application_tripmate/features/home/widgets/home_header.dart';
import 'package:flutter_application_tripmate/features/home/widgets/recommended_hotels.dart';
import 'package:flutter_application_tripmate/features/home/widgets/search_section.dart';
import 'package:flutter_application_tripmate/widgets/main_layout.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      currentIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            HomeHeader(),
            SizedBox(height: AppSizes.spacing24),
            SearchSection(),
            SizedBox(height: AppSizes.spacing24),
            CategoryList(),
            SizedBox(height: AppSizes.spacing24),
            DestinationCard(),
            SizedBox(height: AppSizes.spacing24),
            RecommendedHotels(),
          ],
        ),
      ),
    );
  }
}
