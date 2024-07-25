import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:cubit_products/data/model/product_model.dart';

//Test için yorum bloğunu kaldırın dio nesnesini kapatın.
class ProductProvider {
  /* Dio? _dio;

  set dio(Dio dio) {
    _dio = dio;
  } */

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com/'));

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio!.get("products");
      List<dynamic> data = response.data;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      log("Error fetching data: $e");
      return Future.error(e.toString());
    }
  }

  Future<ProductModel> getProductDetail(int id) async {
    try {
      final response = await _dio!.get("products/$id");
      Map<String, dynamic> data = response.data;
      return ProductModel.fromJson(data);
    } catch (e) {
      log("Error fetching data: $e");
      return Future.error(e.toString());
    }
  }
} 