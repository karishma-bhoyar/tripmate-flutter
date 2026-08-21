import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tripmate/config/routes/app_router.gr.dart';
import 'package:flutter_application_tripmate/core/constants/app_colors.dart';
import 'package:flutter_application_tripmate/core/constants/app_size.dart';
import 'package:flutter_application_tripmate/core/constants/assets.dart';
import 'package:flutter_application_tripmate/core/theme/app_text_style.dart';
import 'package:flutter_application_tripmate/widgets/common/app_svg.dart';
import 'package:flutter_application_tripmate/widgets/common/primary_button.dart';

class OnboardingPageData {
  final String image;
  final String titleHighlight;
  final String titleNormal;
  final String description;

  OnboardingPageData({
    required this.image,
    required this.titleHighlight,
    required this.titleNormal,
    required this.description,
  });
}

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingPageData> pages = [
    OnboardingPageData(
      image: AppAssets.onboarding1,
      titleHighlight: 'Discover\n',
      titleNormal: 'beautiful places',
      description:
          'Find amazing destinations around the world and plan your perfect getaway.',
    ),
    OnboardingPageData(
      image: AppAssets.onboarding2,
      titleHighlight: 'Book\n',
      titleNormal: 'your favorite trip',
      description:
          'Reserve flights, hotels, and tours easily with secure payment options.',
    ),
    OnboardingPageData(
      image: AppAssets.onboarding3,
      titleHighlight: 'Enjoy\n',
      titleNormal: 'your holiday',
      description:
          'Create unforgettable memories and share your travel experiences with others.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    context.router.replace(const LoginRoute());
  }

  void _onNext() {
    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      _onSkip();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(
            left: AppSizes.spacing24,
            right: AppSizes.spacing24,
            top: AppSizes.spacing16,
            bottom: AppSizes.spacing24,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _onSkip,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Skip',
                    style: AppTextStyles.title.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.spacing10),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: AppSvg(
                              assetPath: page.image,
                              height: 280,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacing20),
                        Text.rich(
                          TextSpan(
                            text: page.titleHighlight,
                            style: AppTextStyles.heading.copyWith(
                              color: AppColors.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: '${page.titleNormal}\n\n',
                                style: AppTextStyles.heading,
                              ),
                              TextSpan(
                                text: page.description,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DotIndicator(
                    currentIndex: currentIndex,
                    totalDots: pages.length,
                  ),
                  PrimaryButton(
                    width: 140,
                    text: currentIndex == pages.length - 1 ? 'Get Started' : 'Next',
                    onPressed: _onNext,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;
  const DotIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.spacing4),
          width: currentIndex == index ? AppSizes.spacing20 : AppSizes.spacing8,
          height: AppSizes.spacing8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.primaryColor
                : AppColors.greyColor,
            borderRadius: BorderRadius.circular(AppSizes.radius20),
          ),
        );
      }),
    );
  }
}
