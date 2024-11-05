class Partner {
  int? id;
  int? userId;
  String? storeName;
  String? address;
  String? city;
  String? province;
  String? openAt;
  String? closeAt;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  Partner(
      {this.id,
      this.userId,
      this.storeName,
      this.address,
      this.city,
      this.province,
      this.openAt,
      this.closeAt,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'],
      userId: json['user_id'],
      storeName: json['store_name'],
      address: json['address'],
      city: json['city'],
      province: json['province'],
      openAt: json['open_at'],
      closeAt: json['close_at'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'store_name': storeName,
      'address': address,
      'city': city,
      'province': province,
      'open_at': openAt,
      'close_at': closeAt,
      'latitude': latitude,
      'longitude': longitude,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
