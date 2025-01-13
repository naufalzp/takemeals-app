import 'dart:convert';

import 'package:takemeals/common/failure.dart';
import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/models/token_model.dart';
import 'package:dartz/dartz.dart';
import 'package:takemeals/services/api_service.dart';

class TokenService {
  Future<Either<Failure, TokenModel>> getToken(Product product, int quantity) async {
    final ApiService apiService = ApiService();

    try {
      var response = await apiService.post('midtrans/token', {
        "id": DateTime.now().millisecondsSinceEpoch.toString(), 
        "productName": product.name,
        "price": product.price,
        "quantity": quantity
      });

      print('Token Service: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return right(TokenModel(token: jsonResponse['token']));
      } else {
        return left(ServerFailure(
            data: response.body,
            code: response.statusCode,
            message: 'Unknown Error'));
      }
    } catch (e) {
      return left(ServerFailure(
          data: e.toString(), code: 400, message: 'Unknown Error'));
    }
  }
}
