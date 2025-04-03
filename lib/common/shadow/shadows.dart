import '/utils/exports.dart';

class WShadowStyle {
  static final verticalProductShadows = BoxShadow(
    color: WColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 2),
  );
  static final horizontalProductShadow = BoxShadow(
    color: WColors.darkGrey.withValues(alpha: 0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: Offset(0, 7),
  );
}
