import '/widgets/texts/product_title_text.dart';
import '/utils/exports.dart';

class WProductCardVertical extends StatelessWidget {
  final String discountText, productName, subProductName, priceText;
  const WProductCardVertical({
    super.key,
    this.discountText = "25%",
    this.productName = "Lacha",
    this.subProductName = "awesome lacha paratha",
    this.priceText = "Rs. 250%",
  });

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [WShadowStyle.verticalProductShadows],
          borderRadius: BorderRadius.circular(WSizes.productImageRadius),
          color: dark ? WColors.darkGrey : WColors.white,
        ),
        child: Column(
          children: [
            // Thumbnail, Wishlist button, Discount Tag
            WRoundedContainer(
              height: 180,
              padding: EdgeInsets.all(WSizes.sm),
              backgroundColor: dark ? WColors.dark : WColors.light,
              child: Stack(
                children: [
                  //thumbnail image
                  WroundedImage(imageUrl: WImages.banner2),
                  //sale tag
                  Positioned(
                    top: 4,
                    left: 4,
                    child: WRoundedContainer(
                      radius: WSizes.sm,
                      backgroundColor: WColors.secondary.withValues(alpha: 0.8),
                      padding: EdgeInsets.symmetric(
                        horizontal: WSizes.sm,
                        vertical: WSizes.xs,
                      ),
                      child: Text(
                        // "25%",
                        discountText,
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: WColors.black),
                      ),
                    ),
                  ),

                  //Favourite icon button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: WCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            //details
            SizedBox(height: WSizes.spaceBtwItems / 2),

            Padding(
              padding: const EdgeInsets.only(left: WSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // "Lacha",
                          productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      SizedBox(width: WSizes.xs),
                      Icon(
                        Iconsax.verify5,
                        color: WColors.primary,
                        size: WSizes.iconXs,
                      ),
                    ],
                  ),
                  SizedBox(height: WSizes.spaceBtwItems / 2),
                  WProductTextTitle(
                    // title: 'awesome lacha paratha',
                    title: subProductName,
                    smallSize: true,
                  ),

                  // Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // "Rs. 250",
                        priceText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: WColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(WSizes.cardRadiusMd),
                            bottomRight: Radius.circular(
                              WSizes.productImageRadius,
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: WSizes.iconLg * 1.2,
                          height: WSizes.iconLg * 1.2,
                          child: Center(
                            child: Icon(Iconsax.add, color: WColors.white),
                          ),
                        ),
                      ),
                    ],
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
