import '/utils/exports.dart';

class WSearchContainer extends StatelessWidget {
  const WSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onChanged,
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    final dark = WHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: WSizes.defaultSpace),
      child: Container(
        width: WDeviceUtils.getScreenWidth(context),
        padding: EdgeInsets.all(WSizes.md),
        decoration: BoxDecoration(
          // color: WColors.white,
          color:
              showBackground
                  ? dark
                      ? WColors.dark
                      : WColors.light
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(WSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: WColors.grey) : null,
        ),
        child: Row(
          children: [
            // Icon(Iconsax.search_normal, color: WColors.darkGrey),
            Icon(icon, color: WColors.darkGrey),
            const SizedBox(width: WSizes.spaceBtwItems),
            Text(text, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
