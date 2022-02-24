class Validator {
  static String validateEmail(String value) {
    if (value.isEmpty) return "Email can't be empty!";

    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern);

    if ((!regex.hasMatch(value))) {
      return "Enter Valid Email";
    } else {
      return "";
    }
  }

  static String validatePassword(String value) {
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

  static String validateContactNo(String value) {
    if (value.isEmpty) {
      return "Contact Number can't be empty!";
    }

    if (value.length != 10) {
      return "Contact Number's length must be 10";
    }

    return "";
  }

  static String validateName(String value) {
    if (value.isEmpty) {
      return "Name can't be empty!";
    }
    if (value.length < 2) {
      return "Please enter a valid name";
    }
    return "";
  }
}
