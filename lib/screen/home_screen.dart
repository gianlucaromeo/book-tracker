import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.displayName ?? user.email}'),
        leading: IconButton(
          onPressed: () {
            final String providerId = user.providerData[0].providerId;
            if (providerId == 'google.com') {
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            } else {
              FirebaseAuth.instance.signOut();
            }
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_btps9sdj.json'),
      ),
    );
  }
}
