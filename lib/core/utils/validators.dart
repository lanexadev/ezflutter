class Validators {
  static bool isValidEmail(String email) {
    //TODO: Test this regex
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}