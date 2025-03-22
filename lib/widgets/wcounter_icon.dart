import '/utils/exports.dart';

class WCounterIcon extends StatelessWidget {
  const WCounterIcon({
    super.key,
    required this.iconcolor,
    required this.onPressed,
  });
  final Color iconcolor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          // onPressed: () {},
          onPressed: onPressed,
          // icon: Icon(Iconsax.shopping_bag, color: WColors.white),
          icon: Icon(Iconsax.shopping_bag, color: iconcolor),
        ),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: WColors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                "2",
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: WColors.white,
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
