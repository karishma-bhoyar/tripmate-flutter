import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onTap;
  const SocialLoginButton({
    super.key,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.radius16),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacing24,
          vertical: AppSizes.spacing16,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.radius16),
          border: Border.all(
            color: AppColors.greyColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: AppSvg(
          assetPath: assetPath,
          height: AppSizes.icon24,
          width: AppSizes.icon24,
        ),
      ),
    );
  }
}
