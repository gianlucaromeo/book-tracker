import 'package:book_tracker/config/padding.dart';
import 'package:book_tracker/features/authentication/widgets/login_form.dart';
import 'package:book_tracker/features/authentication/widgets/signup_form.dart';
import 'package:book_tracker/theme/light_theme_data.dart';
import 'package:book_tracker/util/transparent_divider.dart';
import 'package:flutter/material.dart';

class AuthenticationFormsContainer extends StatefulWidget {
  const AuthenticationFormsContainer({Key? key}) : super(key: key);

  @override
  State<AuthenticationFormsContainer> createState() =>
      _AuthenticationFormsContainerState();
}

class _AuthenticationFormsContainerState
    extends State<AuthenticationFormsContainer>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TabBar(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              indicatorColor: LightThemeData.primary,
              tabs: List.from(
                ['Login', 'Sign Up'].map(
                  (title) => Tab(
                    text: title,
                  ),
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 0.5,
            ),
            TransparentDivider.h(20),
            Expanded(
              child: TabBarView(
                controller: tabController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  LoginForm(),
                  SignUpForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
