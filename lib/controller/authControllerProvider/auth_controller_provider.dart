import 'dart:io';
import 'package:dio/dio.dart';
import '../database/database_controller_provider.dart';
import '../../utils/exports.dart';

class AuthenticationControllerProvider extends ChangeNotifier {
  final dio = Dio();
  //setter
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  String _responseMessage = '';
  //getter
  bool get isLoading => _isLoading;
  bool get isGoogleLoading => _isGoogleLoading;
  String get responseMessage => _responseMessage;

  String _newRoleId = '';
  String get newRoleId => _newRoleId;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool obscureText) {
    _obscurePassword = obscureText;
    notifyListeners();
  }

  bool _obscureConfirmPassword = true;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  set obscureConfirmPassword(bool obscureConfirmText) {
    _obscureConfirmPassword = obscureConfirmText;
    notifyListeners();
  }

  String _passwordValue = '';
  String get password => _passwordValue;
  set passwordValue(String passwordValue) {
    _passwordValue = passwordValue;
    notifyListeners();
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Please enter confirm password';
    } else if (value != password) {
      return 'Confirm password does not match.';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 8) {
      return 'Password can not be less than 8 char.';
    } else {
      return null;
    }
  }

  String? emailValidate(String value) {
    const String format =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    return !RegExp(format).hasMatch(value) ? "Enter valid email" : null;
  }

  String? mobileNumberValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter your Mobile Number';
    } else if (value.length > 10 || value.length < 10) {
      return 'Please enter your 10 digit Mobile Number';
    } else {
      return null;
    }
  }

  String? validateBlankField(String value) {
    if (value.isEmpty) {
      return 'Data required here';
    }
    return null;
  }

  // regular expression to check if string
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePasswordNew(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String mobileNumber,
    required String password,
    required String confirmPassword,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final body = {
      'name': name,
      'email': email,
      'mobile_number': mobileNumber,
      'password': password,
      'password_confirmation': confirmPassword,
    };
    // print(body);

    try {
      final response = await dio.post(AppUrl.registrationUri, data: body);
      if (response.statusCode == 200) {
        // print(response.data);
        _responseMessage = response.data['message'] ?? "Signup successful!";
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        _responseMessage = "Error: ${response.statusCode}";
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _responseMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['name'] != null) {
          throw _responseMessage = errorResponse['name'][0];
        } else if (errorResponse != null && errorResponse['email'] != null) {
          throw _responseMessage = errorResponse['email'][0];
          // throw Exception(_responseMessage);
        } else if (errorResponse != null && errorResponse['password'] != null) {
          throw _responseMessage = errorResponse['password'][0];
        } else if (errorResponse != null &&
            errorResponse['mobile_number'] != null) {
          throw _responseMessage = errorResponse['mobile_number'][0];
        } else if (errorResponse != null && errorResponse['error'] != null) {
          throw Exception(errorResponse['error']);
        }
      }
      throw Exception('Register failed');
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required String deviceToken,
    BuildContext? context,
  }) async {
    // print(AppUrl.loginUri);
    _isLoading = true;
    notifyListeners();
    final body = {
      'email': email,
      'password': password,
      'device_token': deviceToken,
    };
    // print(body);

    try {
      final response = await dio.post(AppUrl.loginUri, data: body);

      if (response.statusCode == 200) {
        // print(response.data);
        _responseMessage = response.data['message'] ?? "Signup successful!";
        _isLoading = false;
        notifyListeners();
        //save in sharedprefrences
        final userId = response.data['user']['id'].toString();
        final roleId = response.data['user']['role_id'].toString();
        final token = response.data['token'];
        _newRoleId = roleId;
        // print("Your user id is : $userId");
        // print("Your token is : $token");
        DatabaseControllerProvider().saveToken(token);
        DatabaseControllerProvider().saveUserId(userId);
        DatabaseControllerProvider().saveRoleId(roleId);
      } else {
        _isLoading = false;
        _responseMessage = "Error: ${response.statusCode}";
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _responseMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['email'] != null) {
          throw _responseMessage = errorResponse['email'][0];
          // throw Exception(_responseMessage);
        } else if (errorResponse != null && errorResponse['password'] != null) {
          throw _responseMessage = errorResponse['password'][0];
        } else if (errorResponse != null && errorResponse['error'] != null) {
          throw Exception(errorResponse['error']);
        }
      }
      throw Exception('Login failed');
    }
  }

  Future<void> googleLogin({
    required String name,
    required String email,
    String? googleId,
    required String deviceToken,
    BuildContext? context,
  }) async {
    // print(AppUrl.loginUri);
    _isGoogleLoading = true;
    notifyListeners();
    final body = {
      'name': name,
      'email': email,
      'google_id': googleId,
      'device_token': deviceToken,
    };
    // print(body);

    try {
      final response = await dio.post(AppUrl.googleLoginUri, data: body);

      if (response.statusCode == 200) {
        // print(response.data);
        _responseMessage = response.data['message'] ?? "Signup successful!";
        _isGoogleLoading = false;
        notifyListeners();
        //save in sharedprefrences
        final userId = response.data['user']['id'].toString();
        final roleId = response.data['user']['role_id'].toString();
        final token = response.data['token'];
        _newRoleId = roleId;
        // print("Your user id is : $userId");
        // print("Your token is : $token");
        DatabaseControllerProvider().saveToken(token);
        DatabaseControllerProvider().saveUserId(userId);
        DatabaseControllerProvider().saveRoleId(roleId);
      } else {
        _isGoogleLoading = false;
        _responseMessage = "Error: ${response.statusCode}";
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isGoogleLoading = false;
      _responseMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isGoogleLoading = false;
      notifyListeners();

      if (e is DioException) {
        final errorResponse = e.response?.data;
        if (errorResponse != null && errorResponse['error'] != null) {
          throw Exception(errorResponse['error']);
        }
      }
      throw Exception('Login failed');
    }
  }

  Future<void> forgotPassword({
    required String email,
    BuildContext? context,
  }) async {
    _isLoading = true;
    notifyListeners();
    final body = {'email': email};

    try {
      final response = await dio.post(AppUrl.forgotPasswordUri, data: body);

      if (response.statusCode == 200) {
        _isLoading = false;
        _responseMessage = response.data['data'];
        notifyListeners();
      } else {
        _isLoading = false;
        if (response.statusCode == 401) {
          _responseMessage = "Invalid email";
        } else {
          _responseMessage = "Error: ${response.statusCode}";
        }
        notifyListeners();
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _responseMessage = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();

      if (e is DioException) {
        final errorResponse = e.response?.data;

        if (errorResponse != null && errorResponse['error'] != null) {
          throw Exception(errorResponse['error']);
        }
      }
      throw Exception('Email is not exist!');
    }
  }

  void clear() {
    _responseMessage = '';
    notifyListeners();
  }
}
