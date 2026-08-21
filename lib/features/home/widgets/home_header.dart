import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/view/auth/data/auth_service.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _userName = '';

  Future<void> _logOut() async {
    await _authService.logOut();
    if (!mounted) return;
    context.router.replace(LoginRoute());
  }

  Future<void> _getUserName() async {
    final User? user = _authService.currentUser;

    if (user == null) return;
    final DocumentSnapshot userData = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();
    if (!mounted) return;
    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;
      setState(() {
        _userName = data['name'] ?? '';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: AppTextStyles.title.copyWith(color: AppColors.greyColor),
            ),
            const SizedBox(height: AppSizes.spacing4),
            Text(
              _userName.isEmpty ? 'User' : _userName,
              style: AppTextStyles.heading,
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {},
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
              onTap: _logOut,
              borderRadius: BorderRadius.circular(AppSizes.radius100),
              child: CircleAvatar(
                radius: AppSizes.radius20,
                backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                child: AppSvg(
                  assetPath: AppAssets.profileIcon,
                  height: AppSizes.icon20,
                  width: AppSizes.icon20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
