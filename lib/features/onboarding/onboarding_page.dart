import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/config/shared_preferences.dart';
import 'package:book_tracker/features/onboarding/data/sections_data.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/main.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        body: buildBody(onboardingSections),
        bottomSheet: _isLastPage
            ? buildLastPageButton(context)
            : buildBottomContainer(
                _bottomContainerHeight, onboardingSections, context),
      ),
    );
  }

  final double _bottomContainerHeight = 80.0;

  final TextStyle _bottomButtonTextStyle = const TextStyle(
    //color: Palette.primaryLight,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  Container buildBody(List<OnboardingSection> onboardingSections) {
    return Container(
      padding: EdgeInsets.only(bottom: _bottomContainerHeight),
      color: Theme.of(context).scaffoldBackgroundColor, // to cover some grey from last animation
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
        style: _bottomButtonTextStyle,
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
        style: _bottomButtonTextStyle,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      //backgroundColor: Theme.of(context).bottomAppBarColor,//Colors.white,
      //elevation: 0.0,
      //toolbarHeight: 80.0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context)
              .popAndPushNamed(Routes.chooseLanguagePageRouteName);
        },
        icon: Icon(
          Icons.arrow_back,
          //color: Theme.of(context).primaryColor, // TODO
          size: 38.0,
        ),
      ),
    );
  }

  Container buildLastPageButton(BuildContext context) {
    return Container(
      //color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          child: Text(
            AppLocalizations.of(context)!.letsStartOnboarding,
            style: const TextStyle(
              fontSize: 24.0,
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
            //primary: colors.white,
            //backgroundColor: Palette.primaryLight,
            minimumSize: const Size.fromHeight(80.0),
          ),
        ),
      ),
    );
  }
}
