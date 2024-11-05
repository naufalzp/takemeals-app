import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/services/api_service.dart';

class ProductProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final response = await apiService.get('products');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List data = responseData['data'];
        _products = data.map((item) => Product.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch products: $e');
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await apiService.post('products', product.toJson());
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _products.add(Product.fromJson(responseData['data']));
        notifyListeners();
      }
    } catch (e) {
      print('Failed to add product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      final response = await apiService.put('products/${product.id}', product.toJson());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final index = _products.indexWhere((p) => p.id == product.id);
        if (index != -1) {
          _products[index] = Product.fromJson(responseData['data']);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Failed to update product: $e');
    }
  }

  Future<void> deleteProduct(int productId) async {
    try {
      final response = await apiService.delete('products/$productId');
      if (response.statusCode == 200) {
        _products.removeWhere((product) => product.id == productId);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }
}
