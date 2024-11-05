import 'package:takemeals/models/product_model.dart';
import 'package:takemeals/models/user_model.dart';

class Order {
  int? id;
  String? orderNumber;
  int? userId;
  int? productId;
  int? quantity;
  int? totalPrice;
  String? paymentMethod;
  String? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  User? user;
  Product? product;

  Order(
      {this.id,
      this.orderNumber,
      this.userId,
      this.productId,
      this.quantity,
      this.totalPrice,
      this.paymentMethod,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.user,
      this.product});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      userId: json['user_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      totalPrice: json['total_price'],
      paymentMethod: json['payment_method'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'total_price': totalPrice,
      'payment_method': paymentMethod,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user': user?.toJson(),
      'product': product?.toJson(),
    };
  }
}
