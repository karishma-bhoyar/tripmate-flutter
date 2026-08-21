import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/view/auth/data/auth_service.dart';
import 'package:flutter_application_tripmate/view/auth/widget/custom_terxtfield.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPassWordController =
      TextEditingController();
  bool _agreeToTerms = false;
  bool _isLoading = false;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passWordController.dispose();
    _confirmPassWordController.dispose();
    super.dispose();
  }

  final AuthService _authService = AuthService();

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please agree to the Terms & Conditions')),
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passWordController.text.trim(),
        _nameController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Account created successfully!')));
      context.router.replace(HomeRoute());
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "SignUp failed")));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.spacing24,
              vertical: AppSizes.spacing16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: AppSizes.spacing10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppSizes.radius12),
                      onTap: () => context.router.maybePop(),
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.spacing10),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(
                            AppSizes.radius12,
                          ),
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
                  const SizedBox(height: AppSizes.spacing24),
                  Text(
                    'Create Account',
                    style: AppTextStyles.heading.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing8),
                  Text(
                    'Sign up to get started',
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.greyColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacing36),
                  //fullName
                  _buildInputLabel("Full Name"),
                  const SizedBox(height: AppSizes.spacing8),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'enter your full name..',
                    prefixIcon: Icons.person_outline_rounded,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  _buildInputLabel('Email'),
                  const SizedBox(height: AppSizes.spacing8),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'enter your email..',
                    prefixIcon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegExp = RegExp(
                        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
                      );
                      if (!emailRegExp.hasMatch(value.trim())) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  _buildInputLabel('Password'),
                  const SizedBox(height: AppSizes.spacing8),
                  CustomTextField(
                    controller: _passWordController,
                    hintText: 'enter your password',
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassWord: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.trim().length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  _buildInputLabel('Confirm Password'),
                  const SizedBox(height: AppSizes.spacing8),
                  CustomTextField(
                    controller: _confirmPassWordController,
                    hintText: 'confirm password',
                    prefixIcon: Icons.lock_outline_rounded,
                    isPassWord: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passWordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.spacing20),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          activeColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: AppSizes.spacing12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.body.copyWith(
                              fontSize: 14,
                              color: AppColors.blackColor,
                            ),
                            children: [
                              const TextSpan(text: 'I agree to the '),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.spacing32),
                  PrimaryButton(
                    text: 'Sign Up',
                    onPressed: () {
                      _handleSignUp();
                    },
                    isLoading: _isLoading,
                  ),
                  const SizedBox(height: AppSizes.spacing32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.body.copyWith(
                          color: AppColors.greyColor,
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.router.maybePop(),
                        child: Text(
                          'Login',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
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
      ),
    );
  }
}

Widget _buildInputLabel(String labelText) {
  return Text(
    labelText,
    style: AppTextStyles.body.copyWith(
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );
}
