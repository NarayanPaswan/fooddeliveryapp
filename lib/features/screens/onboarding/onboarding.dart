import 'package:fooddelivery/features/screens/authentication/login/login.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/utils/exports.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          //horizontal scroll page
          PageView(
            controller: controller,
            children: [
              OnBoardingPageWidget(
                image: WImages.onBoardingImage1,
                title: WTexts.onBoardingTitle1,
                subTitle: WTexts.onBoardingSubTitle1,
              ),
              OnBoardingPageWidget(
                image: WImages.onBoardingImage2,
                title: WTexts.onBoardingTitle2,
                subTitle: WTexts.onBoardingSubTitle2,
              ),
              Column(
                children: [
                  OnBoardingPageWidget(
                    image: WImages.onBoardingImage3,
                    title: WTexts.onBoardingTitle3,
                    subTitle: WTexts.onBoardingSubTitle3,
                  ),
                  CustomOutlineButton(
                    onPressed: () {
                      PageNavigator(
                        ctx: context,
                      ).nextPageOnly(page: LoginScreen());
                    },
                    text: WTexts.signIn,
                  ),
                ],
              ),
            ],
          ),

          //skip button
          Positioned(
            top: WDeviceUtils.getAppBarHeight(),
            right: WSizes.defaultSpace,
            child: TextButton(
              onPressed: () {
                controller.jumpToPage(2);
              },
              child: Text("Skip"),
            ),
          ),

          //Dot Navigation smoothpage indicator
          Positioned(
            bottom: WDeviceUtils.getBottomNavigationBarHeight() + 25,
            left: WSizes.defaultSpace,
            child: SmoothPageIndicator(
              controller: controller,
              count: 3,
              effect: ExpandingDotsEffect(
                dotHeight: 6,
                activeDotColor: dark ? WColors.light : WColors.dark,
              ),
              onDotClicked:
                  (index) => controller.animateToPage(
                    index,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn,
                  ),
            ),
          ),

          //circular button
          Positioned(
            right: WSizes.defaultSpace,
            bottom: WDeviceUtils.getBottomNavigationBarHeight() + 15,
            child: ElevatedButton(
              onPressed: () {
                controller.nextPage(
                  duration: Duration(microseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: dark ? WColors.primary : Colors.black,
              ),
              child: Icon(Iconsax.arrow_right_3, color: WColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
