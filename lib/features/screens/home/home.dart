import 'package:provider/provider.dart';
import '../../../controller/home_controller_provider.dart';
import '/widgets/appbar/appbar.dart';
import '/utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = HomeControllerProvider();

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
                          child: Consumer<HomeControllerProvider>(
                            builder: (context, homeControllerProvider, child) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    homeControllerProvider
                                        .categoriesList
                                        .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  // ✅ Access the category item correctly using index
                                  final category =
                                      homeControllerProvider
                                          .categoriesList[index];
                                  return WCategoryList(
                                    image:
                                        AppUrl.imageUrl +
                                        (category.image ?? ""),
                                    title:
                                        category.name ??
                                        "Unknown", // Fallback for missing name
                                    onTap: () {
                                      if (kDebugMode) {
                                        print("Tapped on ${category.name}");
                                      }
                                    },
                                  );
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
