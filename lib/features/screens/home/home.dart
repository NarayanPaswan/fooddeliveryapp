import 'package:fooddelivery/widgets/appbar/appbar.dart';

import '/utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WPrimaryHeaderContainer(
              child: Column(
                children: [
                  WAppBar(
                    showBackArrow: false,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          WTexts.homeAppbarTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.apply(color: WColors.grey),
                        ),

                        Text(
                          WTexts.homeAppbarSubTitle,
                          style: Theme.of(context).textTheme.headlineSmall!
                              .apply(color: WColors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
