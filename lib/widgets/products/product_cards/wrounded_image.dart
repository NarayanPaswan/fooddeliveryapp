import '/utils/exports.dart';

class WroundedImage extends StatelessWidget {
  const WroundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPress,
    this.width = 170,
    this.height = 170,
    this.applyImageRadius = true,
    required this.imageUrl,
    this.backGroundColor = WColors.light,
    this.borderRadius = WSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backGroundColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPress;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backGroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius:
              applyImageRadius
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
          child: Image(image: AssetImage(imageUrl), fit: BoxFit.contain),
        ),
      ),
    );
  }
}
