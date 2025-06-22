import 'package:fooddelivery/controller/product_provider.dart';
import 'package:provider/provider.dart';
import '/widgets/appbar/appbar.dart';
import '/utils/exports.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    // final dark = WHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: ListView(
        children: [
          WPrimaryHeaderContainer(
            child: Column(
              children: [
                SizedBox(height: WSizes.borderRadiusMd),
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
                WSearchContainer(onChanged: (value) {}),
              ],
            ),
          ),

          //body
          //banner
          Column(
            children: [
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
