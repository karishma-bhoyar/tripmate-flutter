import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

class DeviderText extends StatelessWidget {
  final String text;
  const DeviderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.greyColor.withValues(alpha: 0.3),
            thickness: 1,
            endIndent: AppSizes.spacing16,
          ),
        ),
        Text(
          text,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.greyColor.withValues(alpha: 0.3),
            thickness: 1,
            indent: AppSizes.spacing16,
          ),
        ),
      ],
    );
  }
}
