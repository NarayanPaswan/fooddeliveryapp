import '../exports.dart';

class AppErrorSnackBar {
  final BuildContext context;
  AppErrorSnackBar(this.context);
  void error(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$e"),
        // behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }
}
