import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plugdin/constants/app_colors.dart';
import 'package:plugdin/constants/app_text_style.dart';
import 'package:plugdin/constants/asset_paths.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/cubit.dart';
import 'package:plugdin/features/onboarding/presentation/cubit/state.dart';
import 'package:plugdin/go_router/exports.dart';
import 'package:plugdin/utils/widgets/core_widgets/button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  final List<({String img, String subtitle, String title})> _steps = const [
    (
      img: AssetPaths.onboardingStep1,
      title: 'Thrift that speaks',
      subtitle: 'Discover preloved clothing and accessories.',
    ),
    (
      img: AssetPaths.onboardingStep2,
      title: 'Planet-friendly fashion',
      subtitle: 'Shop second-hand and reduce fashion waste.',
    ),
    (
      img: AssetPaths.onboardingStep3,
      title: 'Start selling your style',
      subtitle: 'Declutter your closet and earn while helping the planet.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingFlowCubit, OnboardingFlowState>(
      builder: (context, state) {
        final currentPage = context
            .read<OnboardingFlowCubit>()
            .state
            .currentPage;
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemCount: _steps.length,
                itemBuilder: (_, i) => Image.asset(
                  _steps[i].img,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'R.',
                        style: context.h2.copyWith(
                          color: AppColors.offWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Column(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Text(
                              _steps[currentPage].title,
                              key: ValueKey(currentPage),
                              textAlign: TextAlign.center,
                              style: context.h3.copyWith(
                                color: AppColors.offWhite,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Text(
                              _steps[currentPage].subtitle,
                              key: ValueKey('sub$currentPage'),
                              textAlign: TextAlign.center,
                              style: context.t3.copyWith(
                                color: AppColors.offWhite,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 24,
                              bottom: 12,
                            ),
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: _steps.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                dotColor: AppColors.offWhite.withValues(
                                  alpha: 0.5,
                                ),
                                activeDotColor: AppColors.offWhite,
                              ),
                            ),
                          ),

                          FitThereButton(
                            text: 'Continue as guest',
                            backgroundColor: Colors.transparent,
                            onPressed: () {},
                          ),
                          FitThereButton.secondary(
                            text: 'Get started',
                            fontWeight: FontWeight.w700,
                            onPressed: () {
                              context.goNamed(
                                AppRouteNames.accountCreationScreen,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
