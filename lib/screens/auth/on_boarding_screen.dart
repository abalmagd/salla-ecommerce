import 'package:flutter/material.dart';
import 'package:salla/screens/auth/register_screen.dart';
import 'package:salla/widgets/button.dart';

import 'login_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
              text: 'login',
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  )),
            ),
            DefaultButton(
              text: 'register',
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
