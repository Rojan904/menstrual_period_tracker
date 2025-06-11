import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:menstraul_period_tracker/auth/signin/signin_screen.dart';
import 'package:menstraul_period_tracker/auth/signup/model/user.dart';
import 'package:menstraul_period_tracker/shared/index.dart';
import 'package:menstraul_period_tracker/auth/signup/sign_up_form.dart';
import 'package:menstraul_period_tracker/shared/validator.dart';

import 'package:menstraul_period_tracker/theme.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    //closing onlu one box
    Hive.box('users').close();
    //can close al bpx wirh hive.close()
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Create Account',
                  style: titleText,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'Already a member?',
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
                                builder: (context) => const LogInScreen()));
                      },
                      child: Text(
                        'Log In',
                        style: textButton.copyWith(
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SignUpForm(
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  phoneController: phoneController,
                  passwordController: passwordController,
                  emailValidator: validateEmail,
                  phoneValidator: validatePhone,
                  passwordValidator: validateField,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CheckBox('Agree to terms and conditions.'),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                signup();
              }
            },
            child: const PrimaryButton(buttonText: 'Sign Up')),
      ),
    );
  }

  signup() async {
    //referencing the opened box
    var userBox = Hive.box<User>('users');
    var newUser = User(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text);
    await userBox
        .add(newUser)
        .then((value) {
          CustomSnackbar.buildSnackbar(context, "User registered successfully.",
              "Congratulations", ContentType.success);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LogInScreen()));
        })
        .onError((error, stackTrace) => CustomSnackbar.buildSnackbar(context,
            "User registration error.", "Oh, Snap", ContentType.failure))
        .whenComplete(() {
          setState(() {
            firstNameController.text = "";
            lastNameController.text = "";
            emailController.text = "";
            phoneController.text = "";
            passwordController.text = "";
          });
        });
  }
}
