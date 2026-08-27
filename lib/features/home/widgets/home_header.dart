import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/features/notifications/presentation/notification_overlay_sheet.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_bloc.dart';
import 'package:flutter_application_tripmate/features/profile/logic/profile_bloc/profile_state.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _getDynamicGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning 🌅';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon ☀️';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening 🌆';
    } else {
      return 'Good Night 🌙';
    }
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _getDynamicGreeting();

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        String userName = 'User';
        String? photoPath;

        if (state is ProfileLoaded) {
          if (state.userProfile.name.isNotEmpty) {
            userName = state.userProfile.name;
          }
          photoPath = state.userProfile.photoPath;
        }

        final hasPhoto = photoPath != null &&
            photoPath.isNotEmpty &&
            File(photoPath).existsSync();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: AppSizes.spacing4),
                Text(userName, style: AppTextStyles.heading),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () => NotificationOverlaySheet.show(context),
                  borderRadius: BorderRadius.circular(AppSizes.radius100),
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.spacing10),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.greyColor.withValues(alpha: 0.1),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor.withValues(alpha: 0.03),
                          blurRadius: AppSizes.spacing8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: AppSvg(
                      assetPath: AppAssets.notificationIcon,
                      height: AppSizes.icon20,
                      width: AppSizes.icon20,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.spacing12),
                InkWell(
                  onTap: () => context.router.push(const ProfileRoute()),
                  borderRadius: BorderRadius.circular(AppSizes.radius100),
                  child: CircleAvatar(
                    radius: AppSizes.radius20,
                    backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                    backgroundImage:
                        hasPhoto ? FileImage(File(photoPath)) : null,
                    child: !hasPhoto
                        ? AppSvg(
                            assetPath: AppAssets.profileIcon,
                            height: AppSizes.icon20,
                            width: AppSizes.icon20,
                            color: AppColors.primaryColor,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
