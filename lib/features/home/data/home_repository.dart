import '../../../core/models/category_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

abstract class HomeRepository {
  Future<List<CategoryModel>> getCategories();
}

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient apiClient;

  HomeRepositoryImpl({required this.apiClient});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiClient.get(ApiEndpoints.homeCategories);
      if (response is List) {
        return response.map((json) => CategoryModel.fromJson(json)).toList();
      }
    } catch (_) {}

    // Fallback Mock Categories matching Reference Images
    return [
      CategoryModel(id: '1', title: 'Property', iconName: 'home'),
      CategoryModel(id: '2', title: 'Family', iconName: 'family_restroom'),
      CategoryModel(id: '3', title: 'Corporate', iconName: 'business'),
      CategoryModel(id: '4', title: 'Employment', iconName: 'work'),
      CategoryModel(id: '5', title: 'Criminal', iconName: 'gavel'),
      CategoryModel(id: '6', title: 'Consumer', iconName: 'shopping_bag'),
      CategoryModel(id: '7', title: 'Police Issues', iconName: 'local_police'),
      CategoryModel(id: '8', title: 'More', iconName: 'more_horiz'),
    ];
  }
}
