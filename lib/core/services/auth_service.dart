class AuthService {
  bool isLoggedIn = false;

  void login(String username, String password) {
    // TODO: Implement login logic
    if (username == 'admin' && password == 'admin') {
      isLoggedIn = true;
    }
  }

  void logout() {
    isLoggedIn = false;
  }
}