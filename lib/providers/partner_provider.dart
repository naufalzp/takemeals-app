import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:takemeals/models/partner_model.dart';
import 'package:takemeals/services/api_service.dart';

class PartnerProvider with ChangeNotifier {
  ApiService apiService = ApiService();
  List<Partner> _partners = [];

  List<Partner> get partners => _partners;

  Future<void> fetchPartners() async {
    try {
      final response = await apiService.get('partners');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List data = responseData['data'];
        _partners = data.map((item) => Partner.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Failed to fetch partners: $e');
    }
  }

  Future<void> addPartner(Partner partner) async {
    try {
      final response = await apiService.post('partners', partner.toJson());
      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        _partners.add(Partner.fromJson(responseData['data']));
        notifyListeners();
      }
    } catch (e) {
      print('Failed to add partner: $e');
    }
  }

  Future<void> updatePartner(Partner partner) async {
    try {
      final response = await apiService.put('partners/${partner.id}', partner.toJson());
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final index = _partners.indexWhere((p) => p.id == partner.id);
        if (index != -1) {
          _partners[index] = Partner.fromJson(responseData['data']);
          notifyListeners();
        }
      }
    } catch (e) {
      print('Failed to update partner: $e');
    }
  }

  Future<void> deletePartner(int partnerId) async {
    try {
      final response = await apiService.delete('partners/$partnerId');
      if (response.statusCode == 200) {
        _partners.removeWhere((partner) => partner.id == partnerId);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to delete partner: $e');
    }
  }
}
