import '/utils/exports.dart';

class WPrimaryHeaderContainer extends StatelessWidget {
  const WPrimaryHeaderContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return WCurveWidget(
      child: Container(
        color: WColors.primary,
        padding: EdgeInsets.only(bottom: 0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.40, //     (350 / 812),
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: WCircularContainer(
                  backgroundColor: WColors.textWhite.withAlpha((1)),
                ),
              ),

              Positioned(
                top: 100,
                right: -300,
                child: WCircularContainer(
                  backgroundColor: WColors.textWhite.withAlpha((1)),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
