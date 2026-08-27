import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Terms & Conditions',
        subtitle: 'Legal guidelines and user agreement',
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
              Text('Effective Date: August 2026', style: AppTextStyles.caption),
              const SizedBox(height: AppSizes.spacing16),
              _buildHeading('1. Agreement to Terms'),
              _buildParagraph(
                'By accessing or using TripMate, you agree to be bound by these Terms & Conditions. If you disagree with any part, you may not use the services provided.',
              ),
              _buildHeading('2. User Accounts'),
              _buildParagraph(
                'You are responsible for safeguarding your account credentials. You must immediately notify TripMate of any unauthorized use or security breach of your account.',
              ),
              _buildHeading('3. Hotel Reservations & Payments'),
              _buildParagraph(
                'All room rates, taxes, and service fees listed are dynamic. Bookings are subject to hotel availability and confirmed only upon successful payment authorization.',
              ),
              _buildHeading('4. Cancellation & Refunds'),
              _buildParagraph(
                'Cancellation policies vary by property and room tier. Free cancellation deadlines are clearly displayed during checkout and on your booking summary receipt.',
              ),
              _buildHeading('5. Limitation of Liability'),
              _buildParagraph(
                'TripMate acts as an intermediary travel platform and is not liable for direct, indirect, or consequential damages resulting from hotel service disputes or force majeure events.',
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
