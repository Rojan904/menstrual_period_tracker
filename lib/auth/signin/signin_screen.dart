import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/period_cycle/period_cycle_pageview.dart';
import 'package:menstraul_period_tracker/auth/signin/signin_form.dart';
import 'package:menstraul_period_tracker/auth/signup/model/user.dart';
import 'package:menstraul_period_tracker/auth/signup/signup_screen.dart';
import 'package:menstraul_period_tracker/shared/custom_snackbar.dart';
import 'package:menstraul_period_tracker/shared/primary_button.dart';

import 'package:menstraul_period_tracker/theme.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: kDefaultPadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  'Welcome Back',
                  style: titleText,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'New to this app?',
                      style: subTitle,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                LogInForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      signIn();
                    }
                  },
                  child: const PrimaryButton(
                    buttonText: 'Log In',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      var userBox = Hive.box<User>('users');

      // Check if the user exists
      var user = userBox.values.firstWhere(
        (user) =>
            user.email == emailController.text &&
            user.password == passwordController.text,
      );

      // ignore: unnecessary_null_comparison
      if (user != null) {
        setState(() {
          emailController.text = "";
          passwordController.text = "";
        });
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PeriodCyclePageView(),
            ),
          );
        }
        return true;
      } else {
        if (mounted) {
          CustomSnackbar.buildSnackbar(
              context, "Error logging in", "Oh, Snap!", ContentType.failure);
        }

        return false;
      }
    } catch (e) {
      CustomSnackbar.buildSnackbar(
          context, "Error logging in", "Oh, Snap!", ContentType.failure);
      return false;
    }
  }

  // login() async {
  //   // await loading(context);
  //   // Future.delayed(Duration(seconds: 3), () async {
  //   //   await Navigator.maybePop(context);
  //   // });

  //   var userBox = Hive.box<User>('users');
  //   var storedUsers = userBox.values.toList();
  //   for (var user in storedUsers) {
  //     if (user.email == emailController.text &&
  //         user.password == passwordController.text) {
  //       // userBox.put(user.key, User(isLoggedIn: true));
  //       // CustomSnackbar.buildSnackbar(
  //       //     context, "Logged in successfully", "Success", ContentType.success);
  //       setState(() {
  //         emailController.text = "";
  //         passwordController.text = "";
  //       });
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const PeriodCyclePageView(),
  //         ),
  //       );
  //     } else {
  //       CustomSnackbar.buildSnackbar(
  //           context, "Error logging in", "Oh, Snap!", ContentType.failure);
  //     }
  //   }
  // }
}
