import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/app_strings.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/view/auth/data/auth_service.dart';
import 'package:flutter_application_tripmate/view/auth/widget/devider_text.dart';
import 'package:flutter_application_tripmate/view/auth/widget/login_form.dart';
import 'package:flutter_application_tripmate/view/auth/widget/social_login_button.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  Future<void> _handleLogin(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.login(email, password);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Successfully Logged In!')));

      context.router.replace(HomeRoute());
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _handleSocialLogin(String provider) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Logging in with $provider...')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing24,
              vertical: AppSizes.spacing16,
            ),
            child: Column(
              children: [
                const SizedBox(height: AppSizes.spacing20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => context.router.maybePop(),
                    borderRadius: BorderRadius.circular(AppSizes.radius12),
                    child: Container(
                      padding: const EdgeInsets.all(AppSizes.spacing10),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(AppSizes.radius12),
                        border: Border.all(
                          color: AppColors.greyColor.withValues(alpha: 0.2),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.blackColor,
                        size: AppSizes.icon18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spacing20),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.spacing16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: AppSvg(
                      assetPath: AppAssets.logo,
                      height: AppSizes.logoSize,
                      width: AppSizes.logoSize,
                    ),
                  ),
                ),
                const SizedBox(height: AppSizes.spacing32),
                Text(
                  AppStrings.welcomeBack,
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacing8),
                Text(
                  AppStrings.loginSubtitle,
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.greyColor,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSizes.spacing36),
                LoginForm(onSumit: _handleLogin, isLoading: _isLoading),
                const SizedBox(height: AppSizes.spacing36),
                const DeviderText(text: 'Or continue with'),
                const SizedBox(height: AppSizes.spacing28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        assetPath: AppAssets.google,
                        onTap: () => _handleSocialLogin('Google'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacing12),
                    Expanded(
                      child: SocialLoginButton(
                        assetPath: AppAssets.facebook,
                        onTap: () => _handleSocialLogin('Facebook'),
                      ),
                    ),
                    const SizedBox(width: AppSizes.spacing12),
                    Expanded(
                      child: SocialLoginButton(
                        assetPath: AppAssets.apple,
                        onTap: () => _handleSocialLogin('Apple'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacing40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount,
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.router.push(SignUpRoute());
                      },
                      child: Text(
                        AppStrings.signUp,
                        style: AppTextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spacing20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
