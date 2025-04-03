import '../../utils/exports.dart';

class WCircularIcon extends StatelessWidget {
  const WCircularIcon({
    super.key,
    required this.icon,
    this.width,
    this.height,
    this.size = WSizes.lg,
    this.onPressed,
    this.color,
    this.backgroundColor,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color:
            backgroundColor != null
                ? backgroundColor!
                : WHelperFunctions.isDarkMode(context)
                ? WColors.black.withValues(alpha: 0.9)
                : WColors.white.withValues(alpha: 0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color, size: size),
      ),
    );
  }
}
