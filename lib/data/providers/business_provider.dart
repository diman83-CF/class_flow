import 'dart:developer' as developer;
import '../database/database_helper.dart';
import '../../domain/entities/business.dart';

class BusinessProvider {
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  static Future<Business?> getFirstBusiness() async {
    developer.log('Getting first business...');
    final businesses = await _dbHelper.getAllBusinesses();
    final firstBusiness = businesses.isNotEmpty ? businesses.first : null;
    developer.log('First business: ${firstBusiness?.name ?? 'null'}');
    return firstBusiness;
  }
} 