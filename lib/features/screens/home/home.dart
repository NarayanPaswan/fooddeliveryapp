// ignore_for_file: public_member_api_docs, sort_constructors_first

import '/widgets/appbar/appbar.dart';
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
                    action: [
                      WCounterIcon(onPressed: () {}, iconcolor: WColors.white),
                    ],
                  ),
                  //search bar
                  SizedBox(height: WSizes.spaceBtwItems),
                  WSearchContainer(text: WTexts.searchYourFood),
                  //category heding
                  SizedBox(height: WSizes.spaceBtwItems),
                  Padding(
                    padding: const EdgeInsets.only(left: WSizes.defaultSpace),
                    child: Column(
                      children: [
                        WSectionHeading(
                          title: WTexts.categories,
                          textColor: WColors.textWhite,
                        ),
                        //category list
                        SizedBox(height: WSizes.spaceBtwItems),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height *
                              0.12, //     (100 / 812),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              return WCategoryList(
                                image: WImages.google,
                                title: WTexts.breakfast,
                                onTap: () {
                                  if (kDebugMode) {
                                    print("your category");
                                  }
                                },
                              );
                            },
                          ),
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
