class AppUrl {
  static const String baseUrl = "http://192.168.1.2:8000/";
  static const String profilePicUrl = "${baseUrl}storage/users/";
  static const String imageUrl = "${baseUrl}storage/images/";

  static const String registrationUri = "${baseUrl}api/auth/register";
  static const String loginUri = "${baseUrl}api/auth/login";
  static const String logoutUri = "${baseUrl}api/auth/logout";
  static const String userUri = "${baseUrl}api/auth/me";
  static const String googleLoginUri = "${baseUrl}api/auth/google-login";
  static const String forgotPasswordUri = '${baseUrl}api/forgot-password';
  static const String allCategoryUri = '${baseUrl}api/auth/all-category';
  static const String allBannerUri = '${baseUrl}api/auth/all-banner';
}
