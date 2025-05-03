import 'package:carousel_slider/carousel_slider.dart';
import 'package:fooddelivery/controller/product_provider.dart';
import 'package:provider/provider.dart';
import '../../../controller/home_controller_provider.dart';
import '/widgets/appbar/appbar.dart';
import '/utils/exports.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider provider;

  final homeController = HomeControllerProvider();
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int currentIndex = 0;
  YoutubePlayerController? _ytController;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _ytController?.close();
    provider.scrollController.dispose();
    super.dispose();
  }

  void _initializeYouTubeController(String videoId) {
    _ytController?.close(); // Dispose old controller before creating a new one
    _ytController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: YoutubePlayerParams(
        showFullscreenButton: false, // Hide fullscreen button
        showControls: true,
        strictRelatedVideos: true, // Prevents suggested video thumbnails
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final dark = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: ListView(
        controller: provider.scrollController,
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
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall!.apply(color: WColors.white),
                      ),
                    ],
                  ),
                  action: [
                    WCounterIcon(onPressed: () {}, iconcolor: WColors.white),
                  ],
                ),
                //search bar
                SizedBox(height: WSizes.spaceBtwItems),
                // WSearchContainer(text: WTexts.searchYourFood),
                TextField(
                  onChanged: (value) {
                    provider.page = 1;
                    provider.productList.clear();
                    provider.hasMoreData = true;
                    provider.fetchAllProduct(searchQuery: value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                //category heding
                SizedBox(height: WSizes.sm),
                Padding(
                  padding: const EdgeInsets.only(left: WSizes.defaultSpace),
                  child: Column(
                    children: [
                      WSectionHeading(
                        title: WTexts.categories,
                        textColor: WColors.textWhite,
                      ),
                      //category list
                      SizedBox(height: WSizes.sm),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height *
                            0.13, // Adjust height
                        child: Consumer<HomeControllerProvider>(
                          builder: (context, homeControllerProvider, child) {
                            if (homeControllerProvider.categoriesList.isEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5, // Show 5 shimmer placeholders
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      right: WSizes.spaceBtwItems,
                                    ),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade400,
                                      highlightColor: Colors.grey.shade100,
                                      child: Column(
                                        children: [
                                          Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.15,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.07,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors
                                                      .grey
                                                      .shade300, // Placeholder color
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                          ),
                                          SizedBox(
                                            height: WSizes.spaceBtwItems / 2,
                                          ),
                                          Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.12,
                                            height: 10,
                                            color:
                                                Colors
                                                    .grey
                                                    .shade300, // Placeholder for text
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            // Render actual category list when available
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  homeControllerProvider.categoriesList.length,
                              itemBuilder: (_, index) {
                                final category =
                                    homeControllerProvider
                                        .categoriesList[index];
                                return WCategoryList(
                                  image:
                                      AppUrl.imageUrl + (category.image ?? ""),
                                  title: category.name ?? "Unknown",
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

          //body
          //banner
          Column(
            children: [
              Consumer<HomeControllerProvider>(
                builder: (context, homeControllerProvider, child) {
                  if (homeControllerProvider.bannersList.isEmpty) {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      height:
                          MediaQuery.of(context).size.width *
                          (6 / 16), // Adjust height as needed
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!, // Light grey background
                        highlightColor:
                            Colors.grey[100]!, // Shimmer effect color
                        child: Container(
                          width: double.infinity,
                          height:
                              MediaQuery.of(context).size.width *
                              (6 / 16), // Match banner height
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Placeholder color
                            borderRadius: BorderRadius.circular(
                              WSizes.md,
                            ), // Match banner radius
                          ),
                        ),
                      ),
                    );
                  }

                  return CarouselSlider.builder(
                    itemCount: homeController.bannersList.length,
                    itemBuilder: (context, index, realIndex) {
                      final banner = homeController.bannersList[index];

                      if (banner.imageOrLink != null &&
                          banner.imageOrLink!.startsWith("http")) {
                        final videoId = YoutubePlayerController.convertUrlToId(
                          banner.imageOrLink!,
                        );
                        if (videoId == null) {
                          return Center(child: Text("Invalid YouTube URL"));
                        }

                        _initializeYouTubeController(
                          videoId,
                        ); // Initialize player

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(WSizes.md),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: YoutubePlayerScaffold(
                              controller: _ytController!,
                              aspectRatio: 16 / 9,
                              builder: (context, player) => player,
                            ),
                          ),
                        );
                      } else {
                        return WBanner(
                          imageUrl: "${AppUrl.imageUrl}${banner.imageOrLink}",
                        );
                      }
                    },
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.width * (6 / 16),
                      viewportFraction: 1,
                      autoPlay: false,
                    ),
                  );
                },
              ),

              //vertical product
              SizedBox(height: WSizes.spaceBtwItems),

              Consumer<ProductProvider>(
                builder: (context, productProvider, _) {
                  if (productProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // if (productProvider.productList.isEmpty) {
                  //   // return Center(child: Text("No products available."));
                  //   return const Center(child: CircularProgressIndicator());
                  // }

                  if (productProvider.productList.isEmpty) {
                    return const Center(
                      child: Text(
                        "No product found.",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        productProvider.productList.length +
                        (productProvider.hasMoreData ? 1 : 0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: WSizes.defaultSpace,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: WSizes.gridViewSpacing,
                      crossAxisSpacing: WSizes.gridViewSpacing,
                      mainAxisExtent: 288,
                    ),
                    itemBuilder: (context, index) {
                      if (index < productProvider.productList.length) {
                        final product = productProvider.productList[index];
                        return WProductCardVertical(
                          productName: product.name ?? 'No name',
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                },
              ),

              SizedBox(height: WSizes.spaceBtwItems),
            ],
          ),
        ],
      ),
    );
  }
}
