import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/custom_app_bar.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _queryController = TextEditingController();

  final List<Map<String, String>> _faqs = const [
    {
      "question": "How do I cancel my hotel booking?",
      "answer":
          "You can cancel your booking directly under 'My Bookings' section in your Profile. Refunds are processed based on the hotel's cancellation policy."
    },
    {
      "question": "When will I receive booking confirmation?",
      "answer":
          "Booking confirmations are generated instantly upon successful payment and available in your app under 'My Bookings'."
    },
    {
      "question": "What payment methods are supported?",
      "answer":
          "We accept Credit/Debit Cards, UPI, Net Banking, Apple Pay, and Google Pay."
    },
    {
      "question": "How can I contact hotel support?",
      "answer":
          "Each booking summary lists the direct contact details and address for the hotel property."
    },
  ];

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _submitQuery() {
    if (_queryController.text.trim().isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your message has been sent! Support team will respond shortly.'),
        backgroundColor: AppColors.greenColor,
      ),
    );
    _queryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(
        title: 'Help & Support',
        subtitle: '24/7 Assistance and FAQs',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.spacing24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Support Contact Cards
            Row(
              children: [
                Expanded(
                  child: _buildContactCard(
                    icon: Icons.email_outlined,
                    color: AppColors.primaryColor,
                    title: 'Email Us',
                    subtitle: 'support@tripmate.com',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email support: support@tripmate.com')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: AppSizes.spacing16),
                Expanded(
                  child: _buildContactCard(
                    icon: Icons.phone_in_talk_outlined,
                    color: AppColors.greenColor,
                    title: 'Call Us',
                    subtitle: '+1 (800) 874-7628',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Calling support line...')),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.spacing24),

            // FAQs Section
            Text('Frequently Asked Questions', style: AppTextStyles.title),
            const SizedBox(height: AppSizes.spacing12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(AppSizes.radius16),
              ),
              child: Column(
                children: _faqs.map((faq) {
                  return ExpansionTile(
                    title: Text(
                      faq["question"]!,
                      style: AppTextStyles.body.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacing16,
                          vertical: AppSizes.spacing8,
                        ),
                        child: Text(
                          faq["answer"]!,
                          style: AppTextStyles.caption.copyWith(
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: AppSizes.spacing24),

            // Contact Form
            Text('Send Us a Message', style: AppTextStyles.title),
            const SizedBox(height: AppSizes.spacing12),
            TextFormField(
              controller: _queryController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Describe your issue or feedback...',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.greyColor.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: AppColors.whiteColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius16),
                  borderSide: BorderSide(
                    color: AppColors.greyColor.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius16),
                  borderSide: BorderSide(
                    color: AppColors.greyColor.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radius16),
                  borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spacing16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radius12),
                  ),
                ),
                onPressed: _submitQuery,
                child: const Text('Submit Ticket'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius16),
      child: Container(
        padding: const EdgeInsets.all(AppSizes.spacing16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: AppSizes.spacing12),
            Text(title, style: AppTextStyles.title.copyWith(fontSize: 15)),
            const SizedBox(height: AppSizes.spacing4),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
