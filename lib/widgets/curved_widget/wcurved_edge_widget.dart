import '/utils/exports.dart';

class WCurveWidget extends StatelessWidget {
  const WCurveWidget({super.key, this.child});

  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: WCurvedEdge(), child: child);
  }
}
