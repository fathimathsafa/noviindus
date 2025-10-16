import 'package:http/http.dart' as http;
import 'package:noviindus/data/model/category_list_model.dart';
import 'package:noviindus/data/model/home_model.dart';

class HomeService {
  final String baseUrl;
  HomeService({this.baseUrl = 'https://frijo.noviindus.in'});

  Future<CategoryModel> fetchCategories() async {
    final uri = Uri.parse('$baseUrl/api/category_list');
    final res = await http.get(uri);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return categoryModelFromJson(res.body);
    }
    throw Exception('Failed to load categories (${res.statusCode})');
  }

  Future<HomeModel> fetchHome() async {
    final uri = Uri.parse('$baseUrl/api/home');
    final res = await http.get(uri);
    if (res.statusCode >= 200 && res.statusCode < 300) {
      return homeModelFromJson(res.body);
    }
    throw Exception('Failed to load home (${res.statusCode})');
  }
}


