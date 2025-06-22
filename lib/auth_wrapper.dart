import 'package:fooddelivery/features/screens/landing/landing_screen.dart';
import '/features/screens/home/admin_home.dart';
import '/features/screens/onboarding/onboarding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'controller/database/database_controller_provider.dart';
import 'utils/exports.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String roleId = '';

  @override
  void initState() {
    super.initState();
    _fetchRoleId();
  }

  Future<void> _fetchRoleId() async {
    String roleId = await DatabaseControllerProvider().getRoleId();
    setState(() {
      this.roleId = roleId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = DatabaseControllerProvider().getToken();
    return FutureBuilder<String>(
      future: token,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Check if the token has expired
          final tokenExpireTime = JwtDecoder.getExpirationDate(snapshot.data!);
          final currentTime = DateTime.now();
          if (currentTime.isAfter(tokenExpireTime)) {
            // Token has expired, logout and clear token
            DatabaseControllerProvider().logOut();
            return const OnBoardingScreen();
          } else if (roleId == '3') {
            return const LandingScreen();
          } else {
            // Token is valid, show HomeView
            return const AdminHomeScreen();
          }
        } else {
          return const OnBoardingScreen();
        }
      },
    );
  }
}
