import 'package:educanapp/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/onboarding_info.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
      Get.off(const WelcomeScreen());
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/images/readingbook.png', 'Welcome to Educan!',
        'Welcome to Educan, Let’s learn!\nValues Beyond School'),
    OnboardingInfo('assets/images/splash_2.png', "Our Learning Services",
        'Improved access to quality education for all \naround Uganda, East Africa & world-wide'),
    OnboardingInfo('assets/images/manthumbs.png', 'Shop Materials & Services',
        'Every child has the right to learn. \nJust stay with us!')
  ];
}
