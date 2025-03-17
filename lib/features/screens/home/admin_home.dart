import 'package:fooddelivery/features/screens/authentication/login/login.dart';
import '../../../controller/database/database_controller_provider.dart';
import '/utils/exports.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WColors.primaryColor,
        title: Text(WTexts.homeAdmin),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              setState(() {
                DatabaseControllerProvider().logOut();
                PageNavigator(ctx: context).nextPageOnly(page: LoginScreen());
              });
            },
          ),
        ],
      ),
      body: Column(children: [Center(child: Text("Hi Admin"))]),
    );
  }
}
