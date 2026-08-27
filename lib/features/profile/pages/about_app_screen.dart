import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'About TripMate',
        subtitle: 'App version and company information',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spacing16),
            Container(
              padding: const EdgeInsets.all(AppSizes.spacing20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: AppSvg(
                assetPath: AppAssets.logo,
                height: 60,
                width: 60,
              ),
            ),
            const SizedBox(height: AppSizes.spacing16),
            Text('TripMate', style: AppTextStyles.heading),
            Text(
              'Your Ultimate Travel Companion',
              style: AppTextStyles.caption.copyWith(fontSize: 14),
            ),
            const SizedBox(height: AppSizes.spacing8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                'Version 1.0.0 (Build 100)',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacing32),
            Container(
              padding: const EdgeInsets.all(AppSizes.spacing16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TripMate is designed to make global travel seamless, empowering travelers with instant hotel bookings, destination insights, personalized favorites, and real-time trip management.',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.blackColor.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing16),
                  const Divider(),
                  const SizedBox(height: AppSizes.spacing8),
                  _buildFeatureRow(Icons.hotel_rounded, 'Seamless Hotel Bookings'),
                  _buildFeatureRow(Icons.explore_rounded, 'Explore Top Destinations'),
                  _buildFeatureRow(Icons.favorite_rounded, 'Persistent Saved Favorites'),
                  _buildFeatureRow(Icons.verified_user_rounded, 'Secure Firebase Authentication'),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.spacing32),
            Text(
              '© 2026 TripMate Technologies Inc. All rights reserved.',
              textAlign: TextAlign.center,
              style: AppTextStyles.caption.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spacing8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: AppSizes.spacing12),
          Text(label, style: AppTextStyles.body.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
