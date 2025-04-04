import '../exports.dart';

void showMessage({String? message, BuildContext? context}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Text(message!, style: const TextStyle(color: Colors.white)),
      backgroundColor: WColors.primaryColor,
    ),
  );
}
