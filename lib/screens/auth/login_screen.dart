import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:takemeals/screens/auth/register_screen.dart';
import 'package:takemeals/screens/auth/widgets/login_form.dart';
import 'package:takemeals/utils/constants.dart';
import 'package:takemeals/widgets/welcome_text.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeText(
                title: "Welcome to TakeMeals",
                text:
                    "Enter your Email address for login. \nEnjoy your food :)",
              ),
              const LoginForm(),
              const SizedBox(height: defaultPadding),

              Center(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                    text: "Don’t have account? ",
                    children: <TextSpan>[
                      TextSpan(
                        text: "Create new account.",
                        style: const TextStyle(color: primaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              // kOrText,
              // const SizedBox(height: defaultPadding * 1.5),

              // // Google
              // SocialButton(
              //   press: () {},
              //   text: "Login with Google",
              //   color: const Color(0xFF4285F4),
              //   icon: SvgPicture.asset(
              //     'assets/icons/google.svg',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
