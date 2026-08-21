import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';

import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.replaceRoute(HomeRoute());
    } else {
      context.replaceRoute(OnboardingRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSvg(assetPath: AppAssets.logo, height: 200, width: 200),
            const SizedBox(height: AppSizes.spacing20),
            Text(
              'TripMate',
              style: AppTextStyles.heading.copyWith(
                color: AppColors.primaryColor,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: AppSizes.spacing20),
            Text(
              "Explore the World",
              style: AppTextStyles.body.copyWith(
                color: AppColors.greyColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
