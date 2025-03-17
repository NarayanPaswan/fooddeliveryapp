class AppUrl {
  // static const String baseUrl = "https://admin.fasttechcomputer.in/api/";
  // static const String profilePicUrl =
  //     "https://admin.fasttechcomputer.in/public/storage/users/";
  static const String baseUrl = "http://192.168.1.3:8000/api/";
  static const String profilePicUrl =
      "http://192.168.1.3:8000/public/storage/users/";

  static const String registrationUri = "${baseUrl}auth/register";
  static const String loginUri = "${baseUrl}auth/login";
  static const String logoutUri = "${baseUrl}auth/logout";
  static const String userUri = "${baseUrl}auth/me";
  static const String googleLoginUri = "${baseUrl}auth/google-login";
  static const String forgotPasswordUri = '${baseUrl}forgot-password';
}
