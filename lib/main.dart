import 'package:firebase_core/firebase_core.dart';
import 'package:fooddelivery/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controller/authControllerProvider/auth_controller_provider.dart';
import 'controller/database/database_controller_provider.dart';
import '/utils/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationControllerProvider(),
        ),
        ChangeNotifierProvider(create: (_) => DatabaseControllerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: WAppTheme.lightTheme,
        darkTheme: WAppTheme.darkTheme,
        home: SplashScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}
