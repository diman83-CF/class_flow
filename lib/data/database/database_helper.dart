import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../domain/entities/business.dart';
import '../mock/mock_businesses.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static SharedPreferences? _prefs;
  static const String _businessesKey = 'businesses';

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    developer.log('Initializing SharedPreferences...');
    _prefs = await SharedPreferences.getInstance();
    await _initializeData();
    return _prefs!;
  }

  Future<void> _initializeData() async {
    developer.log('Checking if data needs initialization...');
    final businessesJson = _prefs!.getString(_businessesKey);
    if (businessesJson == null) {
      developer.log('Initializing with mock data...');
      final businesses = MockBusinesses.businesses;
      await _prefs!.setString(_businessesKey, jsonEncode(businesses.map((b) => b.toJson()).toList()));
      developer.log('Mock data initialized');
    }
  }

  // Get all businesses
  Future<List<Business>> getAllBusinesses() async {
    developer.log('Getting all businesses...');
    final prefs = await this.prefs;
    final businessesJson = prefs.getString(_businessesKey);
    if (businessesJson == null) return [];
    
    final List<dynamic> businessesList = jsonDecode(businessesJson);
    final businesses = businessesList.map((json) => Business.fromJson(json)).toList();
    developer.log('Found ${businesses.length} businesses');
    for (var business in businesses) {
      developer.log('Business: ${business.name}');
    }
    return businesses;
  }

  // Insert a business
  Future<void> insertBusiness(Business business) async {
    final businesses = await getAllBusinesses();
    businesses.add(business);
    await _saveBusinesses(businesses);
  }

  // Update a business
  Future<void> updateBusiness(Business business) async {
    final businesses = await getAllBusinesses();
    final index = businesses.indexWhere((b) => b.id == business.id);
    if (index != -1) {
      businesses[index] = business;
      await _saveBusinesses(businesses);
    }
  }

  // Delete a business
  Future<void> deleteBusiness(String id) async {
    final businesses = await getAllBusinesses();
    businesses.removeWhere((b) => b.id == id);
    await _saveBusinesses(businesses);
  }

  // Clear all businesses (useful for testing)
  Future<void> clearAllBusinesses() async {
    await _prefs!.remove(_businessesKey);
  }

  Future<void> _saveBusinesses(List<Business> businesses) async {
    final businessesJson = jsonEncode(businesses.map((b) => b.toJson()).toList());
    await _prefs!.setString(_businessesKey, businessesJson);
  }
} 