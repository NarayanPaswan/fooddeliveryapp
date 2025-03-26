import '/utils/exports.dart';

class WCategoryList extends StatelessWidget {
  const WCategoryList({
    super.key,
    required this.image,
    required this.title,
    this.textColor = WColors.white,

    this.onTap,
  });

  final String image, title;
  final Color textColor;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: WSizes.spaceBtwItems),
        child: Column(
          children: [
            Container(
              width:
                  MediaQuery.of(context).size.width *
                  0.15, // approx 68 on 375 screen width 56/375,
              // height:
              //     MediaQuery.of(context).size.height *
              //     (56 / 812),
              height:
                  MediaQuery.of(context).size.height * 0.07, //     (56 / 812),
              padding: EdgeInsets.all(WSizes.sm),
              decoration: BoxDecoration(
                color: dark ? WColors.black : WColors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                  // color: dark ? WColors.light : WColors.dark,
                ),
              ),
            ),
            //text
            const SizedBox(height: WSizes.spaceBtwItems / 2),
            SizedBox(
              width:
                  MediaQuery.of(context).size.width *
                  0.18, // approx 68 on 375 screen width 68*100/375
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
