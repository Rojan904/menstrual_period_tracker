String? validatePhone(String? value) {
  if (value!.isEmpty) {
    return "Please enter phone number.";
  }
  if (value.length != 10) {
    return "Phone number must be 10 characters.";
  } else {
    return null;
  }
}

String? validateLoginPassword(String? value) {
  if (value!.isEmpty) {
    return "Please enter a password.";
  } else if (value.length < 6) {
    return "Password must be greater than 6 characters.";
  }
  return null;
}

String? validateField(String? value) {
  if (value!.isEmpty) {
    return "Please fill the field.";
  }
  return null;
}

String? validateEmail(String? value) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  if (value!.isEmpty) {
    return 'Please fill the field';
  } else {
    if (!regex.hasMatch(value)) {
      return "Please enter valid email.";
    }
    // if (!value.endsWith('@gmail.com || @icloud.com || @outlook.com')) {
    //   return 'Please enter a gmail address';
    // }

    else {
      return null;
    }
  }
}

String? validatePassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  if (value!.isEmpty) {
    return 'Please enter password.';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password.';
    } else {
      return null;
    }
  }
}

String? validateDropdown(String? value) {
  if (value == null) {
    return 'Please select an option.';
  }
  return null;
}
