import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/features/authentication/presentation/pages/login_page.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  final PageController pageController = PageController();

  void updatePageIndicator(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
  }

  void dotNavigationClick(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }

  void nextPage(BuildContext context) {
    if (state < 2) {
      final nextIndex = state + 1;
      emit(nextIndex);
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    } else {
      final storage = GetStorage();
      storage.write('isFirstLaunch', false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }

  void skipPage() {
    const lastPageIndex = 2;
    emit(lastPageIndex);
    pageController.jumpToPage(lastPageIndex);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
