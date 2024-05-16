import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:twitch_clone/src/routes/route_name.dart';
import 'package:twitch_clone/src/widget/custombutton.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to \n Twitch',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomButton(
                onTap: () {
                  context.go(Pagename.loginRoute);
                },
                text: 'Log in',
              ),  
            ),
            CustomButton(
                onTap: () {
                context.go(Pagename.signupRoute);
                },
                text: 'Sign Up'),
          ],
        ),
      ),
    );
  }
}
