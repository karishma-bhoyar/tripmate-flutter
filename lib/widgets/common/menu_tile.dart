import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final VoidCallback onTap;
  final Color? iconColor;

  const MenuTile({
    super.key,
    required this.title,
    this.leadingIcon,
    this.leadingWidget,
    this.trailingWidget,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.spacing12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(AppSizes.radius12),
        border: Border.all(
          color: AppColors.greyColor.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.spacing16,
          vertical: AppSizes.spacing4,
        ),
        leading: leadingWidget ?? (leadingIcon != null
            ? Icon(
                leadingIcon,
                color: iconColor ?? AppColors.primaryColor,
                size: AppSizes.icon20,
              )
            : null),
        title: Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            fontSize: 14,
          ),
        ),
        trailing: trailingWidget ?? Icon(
          Icons.chevron_right_rounded,
          color: AppColors.greyColor.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
