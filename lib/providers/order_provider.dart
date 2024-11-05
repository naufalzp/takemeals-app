import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:takemeals/models/order_model.dart';
import 'package:takemeals/screens/payment/payment_confirmed_screen.dart';
import 'package:takemeals/services/api_service.dart';

class OrderProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  bool _isFetching = false;

  bool get isFetching => _isFetching;
  Future<void> fetchOrders() async {
    _isFetching = true;
    notifyListeners();
    try {
      final response = await apiService.get('orders');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List data = responseData['data'];
        _orders = data.map((item) => Order.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch orders: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> addOrder(BuildContext context, Order order) async {
    _isFetching = true;
    notifyListeners();
    try {
      final response = await apiService.post('orders', order.toJson());
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _orders.add(Order.fromJson(responseData['data']));
        notifyListeners();

        // navigate to payment screen with order data
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentConfirmedScreen(
                order: Order.fromJson(responseData['data']),
              ),
            ),
            (route) => false);
      } else if (response.statusCode == 422) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add order. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internal server error. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Failed to add order: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> updateOrder(Order order) async {
    _isFetching = true;
    notifyListeners();
    try {
      final response =
          await apiService.put('orders/${order.id}', order.toJson());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final index = _orders.indexWhere((p) => p.id == order.id);
        if (index != -1) {
          _orders[index] = Order.fromJson(responseData['data']);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Failed to update order: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> deleteOrder(int orderId) async {
    _isFetching = true;
    notifyListeners();
    try {
      final response = await apiService.delete('orders/$orderId');
      if (response.statusCode == 200) {
        _orders.removeWhere((order) => order.id == orderId);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to delete order: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
