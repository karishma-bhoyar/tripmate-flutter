import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Privacy Policy',
        subtitle: 'How we protect and manage your data',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.spacing20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(AppSizes.radius16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Last updated: August 2026', style: AppTextStyles.caption),
              const SizedBox(height: AppSizes.spacing16),
              _buildHeading('1. Information We Collect'),
              _buildParagraph(
                'We collect information you provide directly to us when registering an account, making a booking, or communicating with us. This includes your name, email address, phone number, and payment preferences.',
              ),
              _buildHeading('2. How We Use Your Information'),
              _buildParagraph(
                'Your information is used strictly to process hotel bookings, verify identity, provide customer support, improve application performance, and send essential transaction notices.',
              ),
              _buildHeading('3. Data Protection & Security'),
              _buildParagraph(
                'We enforce industry-standard TLS encryption, secure database access via Firebase Authentication & Cloud Firestore, and strict token management to safeguard your personal credentials.',
              ),
              _buildHeading('4. Sharing of Information'),
              _buildParagraph(
                'TripMate does not sell, rent, or trade user data to third parties. Data is shared exclusively with confirmed hotel partners to complete your room reservation.',
              ),
              _buildHeading('5. Your Rights'),
              _buildParagraph(
                'You have the right to request access, modification, or complete deletion of your account and associated booking history at any time through our Help & Support channel.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.spacing16, bottom: AppSizes.spacing8),
      child: Text(title, style: AppTextStyles.title.copyWith(fontSize: 15)),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: AppTextStyles.body.copyWith(
        fontSize: 13,
        height: 1.6,
        color: AppColors.blackColor.withValues(alpha: 0.75),
      ),
    );
  }
}
