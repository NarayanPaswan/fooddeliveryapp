import '/utils/exports.dart';

class WRoundedContainer extends StatelessWidget {
  const WRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.showBorder = false,
    this.radius = WSizes.cardRadiusLg,
    this.backgroundColor = WColors.textWhite,
    this.borderColor = WColors.borderPrimary,
  });
  final Widget? child;
  final double? width;
  final double? height;
  final double radius;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
