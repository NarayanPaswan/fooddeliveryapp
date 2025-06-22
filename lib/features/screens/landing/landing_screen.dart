import 'package:fooddelivery/features/screens/home/home.dart';
import '/utils/exports.dart';

class LandingScreen extends StatefulWidget {
  final int initialPage;

  const LandingScreen({super.key, this.initialPage = 0});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late int _page;
  String userId = '';

  String tokenId = '';
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    _page = widget.initialPage;

    super.initState();
  }

  final List<Widget> _pages = [
    // const HomeScreen(),
    Center(child: Text("Home")),
    Center(child: Text("Cart")),
    Center(child: Text("Account")),
  ];

  Color getBgColor() {
    return _page == 0
        ? WColors.navigationBgColor
        : _page == 1
        ? WColors.navigationBgColor
        : WColors.navigationBgColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WColors.white,
      body: _pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Image.asset(
              _page == 0
                  ? 'assets/icon/selected_dashboard.png'
                  : 'assets/icon/dashboard.png',
              width: 20.0,
              height: 20.0,
            ),
            label: 'Dashboard',
            labelStyle: TextStyle(
              color: _page == 0 ? WColors.dashboardColor : WColors.disableColor,
            ),
          ),

          CurvedNavigationBarItem(
            child: Image.asset(
              _page == 1
                  ? 'assets/icon/selected_order.png'
                  : 'assets/icon/order.png',
              width: 20.0,
              height: 20.0,
            ),
            label: 'Orders',
            labelStyle: TextStyle(
              color: _page == 1 ? WColors.ordersColor : WColors.disableColor,
            ),
          ),
          CurvedNavigationBarItem(
            child: Image.asset(
              _page == 2
                  ? 'assets/icon/selected_account.png'
                  : 'assets/icon/account.png',
              width: 20.0,
              height: 20.0,
            ),
            label: 'Account',
            labelStyle: TextStyle(
              color: _page == 2 ? WColors.accountColor : WColors.disableColor,
            ),
          ),
        ],
        buttonBackgroundColor:
            _page == 0
                ? const Color(0xffFF7A00).withOpacity(0.21)
                : _page == 1
                ? const Color(0xff972FFF).withOpacity(0.10)
                : _page == 2
                ? const Color(0xff53E0CE).withOpacity(0.18)
                : Colors.transparent,
        // backgroundColor: Colors.transparent,
        backgroundColor: getBgColor(),

        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
