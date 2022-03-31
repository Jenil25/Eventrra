bool validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return (!regex.hasMatch(value)) ? false : true;
}

class EmailValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Email can't be empty!";
    }
    if (!validateEmail(value)) {
      return 'Valid Email Needed!';
    }
    return "";
  }
}

class PasswordValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Password can't be empty!";
    }
    if (value.length < 6) {
      return "Password length can't be less than 6";
    }
    if (value.length > 13) {
      return "Password length can't be greater than 13";
    }
    return "";
  }
}

class NameValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty!";
    }
    if (value.length < 2) {
      return "Please enter a valid name";
    }
    return "";
  }
}
