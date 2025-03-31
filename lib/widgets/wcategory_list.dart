import '/utils/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.18,
          child: Column(
            children: [
              Container(
                width:
                    MediaQuery.of(context).size.width *
                    0.15, // approx 68 on 375 screen width 56/375,
                height:
                    MediaQuery.of(context).size.height *
                    0.07, //     (56 / 812),
                padding: EdgeInsets.all(WSizes.sm),
                decoration: BoxDecoration(
                  color: dark ? WColors.black : WColors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  // child: Image(
                  //   image: NetworkImage(image),
                  //   fit: BoxFit.cover,
                  //   // color: dark ? WColors.light : WColors.dark,
                  // ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    placeholder:
                        (context, url) =>
                            Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              //text
              const SizedBox(height: WSizes.spaceBtwItems / 2),
              SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.apply(color: textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
