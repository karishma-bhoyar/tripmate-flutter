import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback onTap;
  final bool isActive;

  const CustomChip({
    super.key,
    required this.label,
    this.icon,
    this.trailingIcon,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacing16,
          vertical: AppSizes.spacing8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(AppSizes.radius100),
          border: Border.all(
            color: isActive
                ? AppColors.primaryColor
                : AppColors.greyColor.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isActive ? AppColors.whiteColor : AppColors.greyColor,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isActive ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 4),
              Icon(
                trailingIcon,
                size: 16,
                color: isActive ? AppColors.whiteColor : AppColors.greyColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
