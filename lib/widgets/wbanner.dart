import '../utils/exports.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WBanner extends StatelessWidget {
  const WBanner({super.key, required this.imageUrl, this.onPressed});
  final String imageUrl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: WColors.white,
          borderRadius: BorderRadius.circular(WSizes.md),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(WSizes.md),
          // child: Image(image: NetworkImage(imageUrl), fit: BoxFit.fill),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.fill,
            placeholder:
                (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
