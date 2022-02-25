import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final PageController _pageController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const _bottomContainerHeight = 80.0;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: _bottomContainerHeight),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 2; // TODO constants
            });
          },
          children: [
            Container(color: Colors.red,),
            Container(color: Colors.blueAccent,),
            Container(color: Colors.green,),
          ],
        ),
      ),
      bottomSheet: isLastPage
      ? TextButton(
        child: const Text('Let\'s start!', style: TextStyle(
          fontSize: 24.0,
        )),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Container(color: Colors.pinkAccent,)),
          );
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          primary: Colors.white,
          backgroundColor: Colors.teal.shade700,
          minimumSize: const Size.fromHeight(80.0),
        ),
      ) : Container(height: 80.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => _pageController.jumpToPage(2),
              child: const Text("SKIP"),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                onDotClicked: (index) => _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                ),
              ),
            ),
            TextButton(
              onPressed: () => _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              child: const Text("NEXT"),
            ),
          ],
        ),),
    );
  }
}
