import '../utils/exports.dart';

class WSectionHeading extends StatelessWidget {
  const WSectionHeading({super.key, this.textColor, required this.title});
  final Color? textColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          // "",
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
