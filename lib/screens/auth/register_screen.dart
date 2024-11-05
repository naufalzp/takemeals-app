import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takemeals/screens/auth/login_screen.dart';
import 'package:takemeals/screens/auth/widgets/register_form.dart';
import 'package:takemeals/screens/auth/widgets/social_button.dart';
import 'package:takemeals/widgets/welcome_text.dart';
import 'package:takemeals/utils/constants.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WelcomeText(
                  title: "Create Account",
                  text: "Enter your Name, Email and Password \nfor register.",
                ),
        
                // Register Form
                const RegisterForm(),
                const SizedBox(height: defaultPadding),
        
                // Already have account
                Center(
                  child: Text.rich(
                    TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.w500),
                      text: "Already have account? ",
                      children: <TextSpan>[
                        TextSpan(
                          text: "Login",
                          style: const TextStyle(color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Center(
                  child: Text(
                    "By Signing up you agree to our Terms \nConditions & Privacy Policy.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                kOrText,
                const SizedBox(height: defaultPadding),
        
                // Google
                SocialButton(
                  press: () {},
                  text: "Connect with Google",
                  color: const Color(0xFF4285F4),
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
