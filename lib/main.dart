import 'dart:io';

import 'package:book_tracker/config/general_settings.dart';
import 'package:book_tracker/config/shared_prefs.dart';
import 'package:book_tracker/constants/routes.dart';
import 'package:book_tracker/provider/google_sign_in_provider.dart';
import 'package:book_tracker/screen/auth_screen.dart';
import 'package:book_tracker/screen/choose_language_screen.dart';
import 'package:book_tracker/screen/forgot_password_screen.dart';
import 'package:book_tracker/screen/user_pages/user_screen.dart';
import 'package:book_tracker/screen/onboarding_screen.dart';
import 'package:book_tracker/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:book_tracker/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();
late final SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    themeController.addListener(() {
      setState(() {});
    });
    //getPrefs();
    super.initState();
  }

  Future getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ListenableProvider<GoogleSignInProvider>(create: (_) => GoogleSignInProvider(),),
      ],
      child: const BookTrackerApp(),
    );
  }
}

class BookTrackerApp extends StatelessWidget {
  const BookTrackerApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final bool showTutorial = prefs.getBool(SharedPrefsSettings.showTutorialPref) ?? true;
    return MaterialApp(
      title: GeneralSettings.appTitle,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      routes: {
        Routes.chooseLanguageRouteName: (context) => const ChooseLanguagePage(),
        Routes.onboardingPageRouteName: (context) => const OnboardingPage(),
        Routes.authenticationPageRouteName: (context) => const AuthPage(),
        Routes.homePageRouteName: (context) => const UserPage(),
        Routes.forgotPasswordPageRouteName: (context) => const ForgotPasswordPage(),
      },
      initialRoute: showTutorial ? Routes.chooseLanguageRouteName : Routes.authenticationPageRouteName, //
      theme: themeController.lightThemeData,
      darkTheme: themeController.darkThemeData,
      themeMode: themeController.currentThemeMode,
      locale: localeProvider.currentLocale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
