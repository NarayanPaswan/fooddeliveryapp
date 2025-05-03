import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fooddelivery/controller/home_controller_provider.dart';
import 'package:fooddelivery/controller/product_provider.dart';
import 'package:fooddelivery/splash_screen.dart';
import 'package:provider/provider.dart';
import 'controller/authControllerProvider/auth_controller_provider.dart';
import 'controller/database/database_controller_provider.dart';
import '/utils/exports.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Only allow portrait mode
  ]).then((_) {
    runApp(MyApp());
  });
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
        ChangeNotifierProvider(create: (_) => HomeControllerProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
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
