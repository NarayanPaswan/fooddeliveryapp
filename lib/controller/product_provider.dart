import 'package:fooddelivery/controller/database/database_controller_provider.dart';
import 'package:fooddelivery/model/product_model.dart';
import '../utils/exports.dart';

class ProductProvider extends ChangeNotifier {
  final dio = Dio();
  //setter
  bool _isLoading = false;
  //getter
  bool get isLoading => _isLoading;

  final scrollController = ScrollController();

  //this is constructor to init any function.
  ProductProvider() {
    scrollController.addListener(scrollListener);
    fetchAllProduct();
  }

  int page = 1;
  List productList = [];
  bool isLoadingMore = false;
  bool hasMoreData = true;

  Future<void> fetchAllProduct({String? searchQuery}) async {
    String token = await DatabaseControllerProvider().getToken();
    try {
      String apiUrl = AppUrl.allProductUri;
      apiUrl += '?page=$page';
      if (searchQuery != null) apiUrl += '&search=$searchQuery';

      final response = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      final json = response.data['products']['data'];

      productList.addAll(json.map((e) => Data.fromJson(e)).toList());
      hasMoreData = response.data['products']['next_page_url'] != null;

      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('Error fetching products: $error');
      }
    }
  }

  Future<void> scrollListener() async {
    if (isLoadingMore || !hasMoreData) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoadingMore = true;
      notifyListeners();
      page = page + 1;
      await fetchAllProduct();
      if (kDebugMode) {
        print('Scroll called one time');
      }

      isLoadingMore = false;
      notifyListeners();
    } else {}
  }
}
