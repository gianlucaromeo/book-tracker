import 'package:book_tracker/config/container.dart';
import 'package:book_tracker/config/shared_preferences.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/features/onboarding/data/sections_data.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/theme/text_styles.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/onboarding_section.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  bool _isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingSections =
        OnboardingSectionsData.getOnboardingSections(context);
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: buildPageViewContainer(onboardingSections),
        bottomSheet: _isLastPage
            ? buildLastPageButton(context)
            : buildBottomContainer(
                AppContainer.defaultHeight, onboardingSections, context),
      ),
    );
  }

  Container buildPageViewContainer(List<OnboardingSection> onboardingSections) {
    return Container(
      padding: const EdgeInsets.only(bottom: AppContainer.defaultHeight),
      color: Theme.of(context).scaffoldBackgroundColor, // For last animation
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _isLastPage = index == onboardingSections.length - 1;
          });
        },
        children: onboardingSections,
      ),
    );
  }

  Container buildBottomContainer(double _bottomContainerHeight,
      List<OnboardingSection> onboardingSections, BuildContext context) {
    return Container(
      height: _bottomContainerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSkipButton(onboardingSections, context),
          Center(child: buildPageIndicator(onboardingSections)),
          buildNextButton(context),
        ],
      ),
    );
  }

  TextButton buildNextButton(BuildContext context) {
    return TextButton(
      onPressed: () => _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
      child: Text(
        AppLocalizations.of(context)!.nextOnboarding,
        style: TextStyles.onboardingBottomButton,
      ),
    );
  }

  SmoothPageIndicator buildPageIndicator(
      List<OnboardingSection> onboardingSections) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: onboardingSections.length,
      effect: const SwapEffect(
          //dotColor: Palette.grayLight, // TODO
          //activeDotColor: Palette.primaryLight, // TODO
          ),
      onDotClicked: (index) => _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      ),
    );
  }

  TextButton buildSkipButton(
      List<OnboardingSection> onboardingSections, BuildContext context) {
    return TextButton(
      onPressed: () =>
          _pageController.jumpToPage(onboardingSections.length - 1),
      child: Text(
        AppLocalizations.of(context)!.skipOnboarding,
        style: TextStyles.onboardingBottomButton,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.of(context)
              .popAndPushNamed(Routes.chooseLanguagePageRouteName);
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: themeController.isDarkTheme ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Container buildLastPageButton(BuildContext context) {
    return Container(
      color: themeController.isDarkTheme
          ? Colors.grey.withOpacity(0.2)
          : LightThemeData.primary,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          child: Text(
            AppLocalizations.of(context)!.letsStartOnboarding,
            style: TextStyle(
              fontSize: 24.0,
              letterSpacing: 1,
              color: themeController.isDarkTheme ? Colors.black : Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.authenticationPageRouteName, (route) => false);
            prefs.setBool(SharedPrefsSettings.showTutorialPref, false);
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            minimumSize: const Size.fromHeight(AppContainer.defaultHeight / 2),
          ),
        ),
      ),
    );
  }
}
