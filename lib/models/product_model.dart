import 'package:takemeals/models/partner_model.dart';

class Product {
  int? id;
  int? partnerId;
  String? name;
  String? description;
  String? typeFood;
  int? price;
  String? image;
  int? stock;
  int? expired;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Partner? partner;

  Product({
    this.id,
    this.partnerId,
    this.name,
    this.description,
    this.typeFood,
    this.price,
    this.image,
    this.stock,
    this.expired,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.partner,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      partnerId: json['partner_id'],
      name: json['name'],
      description: json['description'],
      typeFood: json['type_food'],
      price: json['price'],
      image: json['image'],
      stock: json['stock'],
      expired: json['expired'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      partner: json['partner'] != null ? Partner.fromJson(json['partner']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partner_id': partnerId,
      'name': name,
      'description': description,
      'type_food': typeFood,
      'price': price,
      'image': image,
      'stock': stock,
      'expired': expired,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'partner': partner?.toJson(),
    };
  }
}
