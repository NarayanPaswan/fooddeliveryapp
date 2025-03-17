import '../utils/exports.dart';

class WSocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final BuildContext? context;
  final bool? status;

  const WSocialButton({
    super.key,
    required this.onPressed,
    required this.image,
    this.context,
    this.status = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: WColors.grey),
        borderRadius: BorderRadius.circular(100),
      ),
      child: IconButton(
        // onPressed: onPressed,
        onPressed: status == true ? null : onPressed,
        icon: Image.asset(image, width: WSizes.iconMd, height: WSizes.iconMd),
      ),
    );
  }
}
