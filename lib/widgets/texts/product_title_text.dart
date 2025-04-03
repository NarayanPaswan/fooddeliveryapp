import '/utils/exports.dart';

class WProductTextTitle extends StatelessWidget {
  const WProductTextTitle({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLine = 1,
    this.textAlign = TextAlign.left,
  });
  final String title;
  final bool smallSize;
  final int maxLine;
  final TextAlign textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      // "Nice bed with perform",
      title,
      // style: Theme.of(context).textTheme.titleSmall,
      style:
          smallSize
              ? Theme.of(context).textTheme.labelLarge
              : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
