import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  static const String _defaultLanguage = 'he';
  static const String _languageKey = 'selected_language';
  
  static AppLocalizations? _instance;
  static AppLocalizations get instance => _instance ??= AppLocalizations._();
  
  AppLocalizations._();
  
  Map<String, dynamic> _translations = {};
  String _currentLanguage = _defaultLanguage;
  
  String get currentLanguage => _currentLanguage;
  
  static const List<String> supportedLanguages = ['en', 'he'];
  static const List<String> supportedLanguageNames = ['English', 'עברית'];
  
  // Direction support
  TextDirection get textDirection {
    switch (_currentLanguage) {
      case 'he':
        return TextDirection.rtl;
      case 'en':
      default:
        return TextDirection.ltr;
    }
  }
  
  bool get isRTL => textDirection == TextDirection.rtl;
  bool get isLTR => textDirection == TextDirection.ltr;
  
  // Alignment support
  Alignment get startAlignment => isRTL ? Alignment.centerRight : Alignment.centerLeft;
  Alignment get endAlignment => isRTL ? Alignment.centerLeft : Alignment.centerRight;
  
  // Edge support for positioning
  bool get isSideMenuOnRight => isRTL;
  bool get isSideMenuOnLeft => isLTR;
  
  Future<void> initialize() async {
    await _loadSavedLanguage();
    await _loadTranslations();
  }
  
  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentLanguage = prefs.getString(_languageKey) ?? _defaultLanguage;
    } catch (e) {
      _currentLanguage = _defaultLanguage;
    }
  }
  
  Future<void> _loadTranslations() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/translations/$_currentLanguage.json',
      );
      _translations = json.decode(jsonString);
    } catch (e) {
      // Fallback to English if translation file is not found
      if (_currentLanguage != _defaultLanguage) {
        _currentLanguage = 'en';
        await _loadTranslations();
      }
    }
  }
  
  Future<void> setLanguage(String languageCode) async {
    if (!supportedLanguages.contains(languageCode)) return;
    
    _currentLanguage = languageCode;
    await _loadTranslations();
    
    // Save the selected language
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      // Handle error silently
    }
  }
  
  String translate(String key) {
    final keys = key.split('.');
    dynamic value = _translations;
    
    for (final k in keys) {
      if (value is Map && value.containsKey(k)) {
        value = value[k];
      } else {
        return key; // Return the key if translation not found
      }
    }
    
    return value?.toString() ?? key;
  }
  
  // Convenience methods for common translations
  String get appTitle => translate('app.title');
  String get welcome => translate('app.welcome');
  String get selectSection => translate('app.select_section');
  
  // Navigation
  String get home => translate('navigation.home');
  String get activities => translate('navigation.activities');
  String get students => translate('navigation.students');
  String get trainers => translate('navigation.trainers');
  String get leads => translate('navigation.leads');
  
  // Common
  String get search => translate('common.search');
  String get add => translate('common.add');
  String get edit => translate('common.edit');
  String get delete => translate('common.delete');
  String get save => translate('common.save');
  String get cancel => translate('common.cancel');
  String get loading => translate('common.loading');
  String get error => translate('common.error');
  String get success => translate('common.success');
  String get noData => translate('common.no_data');
}

// Extension to make it easier to use in widgets
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.instance;
} 