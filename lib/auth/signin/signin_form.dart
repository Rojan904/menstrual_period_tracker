import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/shared/validator.dart';
import 'package:menstraul_period_tracker/theme.dart';

class LogInForm extends StatefulWidget {
  const LogInForm(
      {super.key,
      required this.emailController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Email', false, widget.emailController, validateEmail),
        buildInputForm(
            'Password', true, widget.passwordController, validateField),
      ],
    );
  }

  Padding buildInputForm(String label, bool pass,
      TextEditingController controller, FormFieldValidator<String>? validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
              color: kTextFieldColor,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            suffixIcon: pass
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: _isObscure
                        ? const Icon(
                            Icons.visibility_off,
                            color: kTextFieldColor,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: kPrimaryColor,
                          ),
                  )
                : null),
      ),
    );
  }
}
