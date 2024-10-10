import 'package:dio/dio.dart';

class MealService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchMeals(String letter) async {
    try {
      final response = await _dio
          .get('https://www.themealdb.com/api/json/v1/1/search.php?f=$letter');
      return response.data['meals'] ?? [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
