import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAllTap;
  final String seeAllText;
  final bool showSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAllTap,
    this.seeAllText = 'See All',
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showSeeAll) ...[
          const SizedBox(width: AppSizes.spacing8),
          InkWell(
            onTap: onSeeAllTap,
            borderRadius: BorderRadius.circular(AppSizes.radius8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    seeAllText,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
