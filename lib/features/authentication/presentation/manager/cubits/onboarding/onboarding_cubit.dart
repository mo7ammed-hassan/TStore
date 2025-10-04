import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/config/service_locator.dart';
import 'package:t_store/core/utils/storage/app_storage.dart';
import 'package:t_store/features/authentication/presentation/widgets/onboarding/onboarding_view.dart';
import 'package:t_store/core/utils/constants/images_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  final PageController pageController = PageController();
  static const _animationDuration = Duration(milliseconds: 300);

  final _storage = getIt<AppStorage>();

  List<Widget> onboardingPages = const [
    OnBoardingView(
      image: TImages.onBoardingImage1,
      title: TTexts.onBoardingTitle1,
      subtitle: TTexts.onBoardingSubTitle1,
    ),
    OnBoardingView(
      image: TImages.onBoardingImage2,
      title: TTexts.onBoardingTitle2,
      subtitle: TTexts.onBoardingSubTitle2,
    ),
    OnBoardingView(
      image: TImages.onBoardingImage3,
      title: TTexts.onBoardingTitle3,
      subtitle: TTexts.onBoardingSubTitle3,
    ),
  ];

  bool _isManualScroll = true;

  int get totalPages => onboardingPages.length;
  bool get isLastPage => state == totalPages - 1;
  bool get hasCompletedOnboarding => state >= onboardingPages.length;

  void changePage(int index) {
    if (_isManualScroll) emit(index);
  }

  void nextPage() async {
    _isManualScroll = false;
    if (isLastPage) {
      emit(totalPages);
      await _storage.setBool('isFirstLaunch', false);
      return;
    }
    final nextPageIndex = state + 1;

    emit(nextPageIndex);
    await pageController.animateToPage(
      nextPageIndex,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );

    _restoreManualScroll();
  }

  void skipPage() async {
    _isManualScroll = false;

    final lastPageIndex = totalPages - 1;
    emit(lastPageIndex);

    await pageController.animateToPage(
      lastPageIndex,
      duration: _animationDuration,
      curve: Curves.easeInOut,
    );

    _restoreManualScroll();
  }

  void _restoreManualScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      _isManualScroll = true;
    });
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
