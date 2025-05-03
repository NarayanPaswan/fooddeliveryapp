import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/exports.dart';

class DatabaseControllerProvider extends ChangeNotifier {
  final dio = Dio();
  final _pref = SharedPreferences.getInstance();

  String _token = '';
  String _userId = '';
  String _roleId = '';

  String get token => _token;
  String get userId => _userId;
  String get roleId => _roleId;

  String _responseMessage = '';
  //getter
  String get responseMessage => _responseMessage;

  void saveToken(String token) async {
    SharedPreferences value = await _pref;
    value.setString('token', token);
  }

  Future<void> saveUserId(String id) async {
    SharedPreferences value = await _pref;
    value.setString('id', id);
  }

  Future<void> saveRoleId(String roleid) async {
    SharedPreferences value = await _pref;
    value.setString('roleid', roleid);
  }

  Future<String> getToken() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('token')) {
      String data = value.getString('token')!;
      _token = data;
      notifyListeners();
      return data;
    } else {
      _token = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getUserId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('id')) {
      String data = value.getString('id')!;
      _userId = data;
      notifyListeners();
      return data;
    } else {
      _userId = '';
      notifyListeners();
      return '';
    }
  }

  Future<String> getRoleId() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('roleid')) {
      String data = value.getString('roleid')!;
      _roleId = data;
      notifyListeners();
      return data;
    } else {
      _roleId = '';
      notifyListeners();
      return '';
    }
  }

  String _latitude = '';
  String get latitude => _latitude;

  Future<String> getLatitude() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('latitude')) {
      String data = value.getString('latitude') ?? '';
      _latitude = data;
      notifyListeners();
      return data;
    } else {
      _latitude = '';
      notifyListeners();
      return '';
    }
  }

  String _longitude = '';
  String get longitude => _longitude;

  Future<String> getLongitude() async {
    SharedPreferences value = await _pref;

    if (value.containsKey('longitude')) {
      String data = value.getString('longitude') ?? '';
      _longitude = data;
      notifyListeners();
      return data;
    } else {
      _longitude = '';
      notifyListeners();
      return '';
    }
  }

  Future<void> logOut() async {
    final value = await _pref;
    value.remove('token');
    value.remove('id');
    value.remove('roleid');

    try {
      final response = await dio.post(
        AppUrl.logoutUri,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Successful logout
        _responseMessage = "Logout successful!";
      } else {
        // Logout failed
        _responseMessage = "Logout failed!";
      }
    } catch (e) {
      // Error occurred during logout
      _responseMessage = "Error: $e";
    }
    // 👉 Google Sign Out
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      debugPrint("Google user signed out");
    } catch (e) {
      debugPrint("Google SignOut error: $e");
    }
    notifyListeners();
  }
}
