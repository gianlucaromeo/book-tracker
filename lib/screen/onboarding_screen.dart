import 'package:book_tracker/config/palette.dart';
import 'package:book_tracker/constants/onboarding_sections_data.dart';
import 'package:book_tracker/screen/login_form.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/onboarding_section.dart';

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
        OnboardingSectionsData.getSections(context).toList();
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(onboardingSections),
        bottomSheet: _isLastPage
            ? _buildLastPageButton(context)
            : _buildBottomContainer(
                _bottomContainerHeight, onboardingSections, context),
      ),
    );
  }

  final double _bottomContainerHeight = 80.0;

  final TextStyle _bottomButtonTextStyle = const TextStyle(
    color: Palette.primaryLight,
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  Container _buildBody(List<OnboardingSection> onboardingSections) {
    return Container(
        padding: EdgeInsets.only(bottom: _bottomContainerHeight),
        color: Colors.white,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _isLastPage = index == onboardingSections.length - 1;
            });
          },
          children: onboardingSections.toList(),
        ),
      );
  }

  Container _buildBottomContainer(double _bottomContainerHeight,
      List<OnboardingSection> onboardingSections, BuildContext context) {
    return Container(
      height: _bottomContainerHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSkipButton(onboardingSections, context),
          Center(child: _buildPageIndicator(onboardingSections)),
          _buildNextButton(context),
        ],
      ),
    );
  }

  TextButton _buildNextButton(BuildContext context) {
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

  SmoothPageIndicator _buildPageIndicator(
      List<OnboardingSection> onboardingSections) {
    return SmoothPageIndicator(
      controller: _pageController,
      count: onboardingSections.length,
      effect: const SwapEffect(
        dotColor: Palette.grayLight,
        activeDotColor: Palette.primaryLight,
      ),
      onDotClicked: (index) => _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      ),
    );
  }

  TextButton _buildSkipButton(
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      toolbarHeight: 80.0,
      leading: IconButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, '/choose_language_page');
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Palette.primaryLight,
          size: 38.0,
        ),
      ),
    );
  }

  _buildLastPageButton(BuildContext context) {
    return Container(
      color: Colors.white,
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
            Navigator.of(context).pushReplacementNamed('/auth_page');
          },
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            primary: Colors.white,
            backgroundColor: Palette.primaryLight,
            minimumSize: const Size.fromHeight(80.0),
          ),
        ),
      ),
    );
  }
}
