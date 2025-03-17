import 'auth_wrapper.dart';
import 'utils/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      // top: 180,
                      top: MediaQuery.of(context).size.height * 0.20,
                      child: const Image(
                        image: AssetImage(WImages.lightAppLogo),
                      ),
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      WTexts.appName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      WTexts.workingWithExcellent,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 80),
                    CustomOutlineButton(
                      onPressed: () {},
                      text: WTexts.getStart,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      PageNavigator(ctx: context).nextPageOnly(page: const AuthWrapper());
    });
  }
}
