import 'package:dio/dio.dart';
import '../models/meal_model.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'));

  Future<List<MealCategory>> fetchCategories() async {
    try {
      final response = await _dio.get('categories.php');
      return (response.data['categories'] as List)
          .map((category) => MealCategory.fromJson(category))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    try {
      final response = await _dio.get('filter.php', queryParameters: {'c': category});
      return (response.data['meals'] as List)
          .map((meal) => Meal.fromJson(meal))
          .toList();
    } catch (e) {
      print('Error fetching meals by category: $e');
      return [];
    }
  }

  Future<Meal> fetchMealDetails(String id) async {
    try {
      final response = await _dio.get('lookup.php', queryParameters: {'i': id});
      if (response.data['meals'] != null && (response.data['meals'] as List).isNotEmpty) {
        return Meal.fromJson(response.data['meals'][0]);
      } else {
        throw Exception('Meal not found');
      }
    } catch (e) {
      print('Error fetching meal details: $e');
      throw Exception('Failed to load meal details');
    }
  }
}
