import 'package:flutter/material.dart';
import 'app_localizations.dart';

class LocalizationProvider extends ChangeNotifier {
  static LocalizationProvider? _instance;
  static LocalizationProvider get instance => _instance ??= LocalizationProvider._();
  
  LocalizationProvider._();
  
  String get currentLanguage => AppLocalizations.instance.currentLanguage;
  List<String> get supportedLanguages => AppLocalizations.supportedLanguages;
  List<String> get supportedLanguageNames => AppLocalizations.supportedLanguageNames;
  
  // Direction support
  TextDirection get textDirection => AppLocalizations.instance.textDirection;
  bool get isRTL => AppLocalizations.instance.isRTL;
  bool get isLTR => AppLocalizations.instance.isLTR;
  
  // Alignment support
  Alignment get startAlignment => AppLocalizations.instance.startAlignment;
  Alignment get endAlignment => AppLocalizations.instance.endAlignment;
  
  // Edge support for positioning
  bool get isSideMenuOnRight => AppLocalizations.instance.isSideMenuOnRight;
  bool get isSideMenuOnLeft => AppLocalizations.instance.isSideMenuOnLeft;
  
  Future<void> initialize() async {
    await AppLocalizations.instance.initialize();
    notifyListeners();
  }
  
  Future<void> setLanguage(String languageCode) async {
    await AppLocalizations.instance.setLanguage(languageCode);
    notifyListeners();
  }
  
  String translate(String key) {
    return AppLocalizations.instance.translate(key);
  }
  
  // Convenience methods
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