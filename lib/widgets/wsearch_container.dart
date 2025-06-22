import '/utils/exports.dart';

class WSearchContainer extends StatelessWidget {
  const WSearchContainer({super.key, this.onChanged});

  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WSizes.md),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodySmall,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: WTexts.searchYourFood,
          prefixIcon: Icon(Iconsax.search_normal, color: WColors.darkGrey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(WSizes.cardRadiusLg),
          ),
          filled: true,
          fillColor: WColors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: WSizes.buttonHeight,
            horizontal: WSizes.defaultSpace,
          ),
        ),
      ),
    );
  }
}
