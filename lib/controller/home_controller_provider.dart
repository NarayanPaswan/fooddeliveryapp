import 'package:fooddelivery/model/banner_model.dart';
import '../model/category_model.dart';
import '../../utils/exports.dart';
import 'database/database_controller_provider.dart';

class HomeControllerProvider extends ChangeNotifier {
  final dio = Dio();
  //this is constructor to init any function.
  HomeControllerProvider() {
    getAllCategory();
    getAllBanner();
  }

  List<Categories> _allCategories = [];
  List<Categories> _filteredCategories = [];
  List<Categories> get categoriesList => _filteredCategories;

  Future<List<Categories>> getAllCategory() async {
    final token = await DatabaseControllerProvider().getToken();
    try {
      const urlAllCategory = AppUrl.allCategoryUri;

      final response = await dio.get(
        urlAllCategory,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      // Ensure the response is a Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        final jsonData = response.data;

        // Extract the "items" list and convert it into List<Items>
        _allCategories =
            (jsonData["categories"] as List)
                .map((item) => Categories.fromJson(item))
                .toList();

        _filteredCategories = List.from(_allCategories);
        // print(_filteredCategories);
        notifyListeners();
      } else {
        if (kDebugMode) {
          print("Unexpected response format: ${response.data}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching categories: $error');
      }
    }
    return _filteredCategories;
  }

  List<Banners> _allBanners = [];
  List<Banners> _filteredBanners = [];
  List<Banners> get bannersList => _filteredBanners;

  Future<List<Banners>> getAllBanner() async {
    final token = await DatabaseControllerProvider().getToken();
    try {
      const urlAllBanner = AppUrl.allBannerUri;

      final response = await dio.get(
        urlAllBanner,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token",
          },
        ),
      );

      // Ensure the response is a Map<String, dynamic>
      if (response.data is Map<String, dynamic>) {
        final jsonData = response.data;

        // Extract the "items" list and convert it into List<Items>
        _allBanners =
            (jsonData["banners"] as List)
                .map((item) => Banners.fromJson(item))
                .toList();

        _filteredBanners = List.from(_allBanners);

        notifyListeners();
      } else {
        if (kDebugMode) {
          print("Unexpected response format: ${response.data}");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching categories: $error');
      }
    }
    return _filteredBanners;
  }
}
