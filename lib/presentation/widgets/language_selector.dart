import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/localization/localization_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        return PopupMenuButton<String>(
          icon: const Icon(Icons.language),
          tooltip: 'Select Language',
          onSelected: (String languageCode) {
            localizationProvider.setLanguage(languageCode);
          },
          itemBuilder: (BuildContext context) {
            return localizationProvider.supportedLanguages.asMap().entries.map((entry) {
              final index = entry.key;
              final languageCode = entry.value;
              final languageName = localizationProvider.supportedLanguageNames[index];
              
              return PopupMenuItem<String>(
                value: languageCode,
                child: Row(
                  children: [
                    Text(
                      _getLanguageFlag(languageCode),
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(languageName),
                    if (languageCode == localizationProvider.currentLanguage)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.check, size: 16),
                      ),
                  ],
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
  
  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'en':
        return '🇺🇸';
      case 'he':
        return '🇮🇱';
      default:
        return '🌐';
    }
  }
} 