import 'package:flutter/material.dart';
import 'package:menstraul_period_tracker/shared/validator.dart';
import 'package:menstraul_period_tracker/theme.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm(
      {super.key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      required this.phoneController,
      required this.passwordController,
      this.emailValidator,
      this.phoneValidator,
      this.passwordValidator});
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final FormFieldValidator<String>? emailValidator;
  final FormFieldValidator<String>? phoneValidator;
  final FormFieldValidator<String>? passwordValidator;
  @override
  // ignore: library_private_types_in_public_api
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm(
            'First Name', false, widget.firstNameController, validateField),
        buildInputForm(
            'Last Name', false, widget.lastNameController, validateField),
        buildInputForm(
            'Email', false, widget.emailController, widget.emailValidator),
        buildInputForm(
            'Phone', false, widget.phoneController, widget.phoneValidator),
        buildInputForm('Password', true, widget.passwordController,
            widget.passwordValidator),
      ],
    );
  }

  Padding buildInputForm(String hint, bool pass,
      TextEditingController controller, FormFieldValidator<String>? validator) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          controller: controller,
          obscureText: pass ? _isObscure : false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kTextFieldColor),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor)),
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
                          ))
                : null,
          ),
        ));
  }
}
