import 'package:flutter/material.dart';

class MenuItem {
  final String id;
  final String title;
  final String route;
  final int order;
  final bool isVisible;
  final IconData? icon;

  const MenuItem({
    required this.id,
    required this.title,
    required this.route,
    required this.order,
    this.isVisible = true,
    this.icon,
  });

  // Factory constructor for creating a MenuItem from JSON
  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      title: json['title'] as String,
      route: json['route'] as String,
      order: json['order'] as int,
      isVisible: json['is_visible'] as bool? ?? true,
      icon: json['icon'] != null ? IconData(json['icon'] as int, fontFamily: 'MaterialIcons') : null,
    );
  }

  // Convert MenuItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'route': route,
      'order': order,
      'is_visible': isVisible,
      'icon': icon?.codePoint,
    };
  }

  // Create a copy of the MenuItem with optional new values
  MenuItem copyWith({
    String? id,
    String? title,
    String? route,
    int? order,
    bool? isVisible,
    IconData? icon,
  }) {
    return MenuItem(
      id: id ?? this.id,
      title: title ?? this.title,
      route: route ?? this.route,
      order: order ?? this.order,
      isVisible: isVisible ?? this.isVisible,
      icon: icon ?? this.icon,
    );
  }
} 