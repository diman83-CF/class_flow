import 'package:flutter/material.dart';
import '../menu_item.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuItem> _menuItems = [];
  String? _currentRoute;

  List<MenuItem> get menuItems => _menuItems;
  String? get currentRoute => _currentRoute;

  // Initialize menu items
  void initializeMenuItems(List<MenuItem> items) {
    _menuItems = items;
    notifyListeners();
  }

  // Add a new menu item
  void addMenuItem(MenuItem item) {
    _menuItems.add(item);
    notifyListeners();
  }

  // Remove a menu item
  void removeMenuItem(String id) {
    _menuItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  // Update menu item visibility
  void setMenuItemVisibility(String id, bool isVisible) {
    final index = _menuItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _menuItems[index] = _menuItems[index].copyWith(isVisible: isVisible);
      notifyListeners();
    }
  }

  // Update menu item order
  void updateMenuItemOrder(String id, int newOrder) {
    final index = _menuItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      _menuItems[index] = _menuItems[index].copyWith(order: newOrder);
      notifyListeners();
    }
  }

  // Set current route
  void setCurrentRoute(String route) {
    _currentRoute = route;
    notifyListeners();
  }

  // Reorder menu items
  void reorderMenuItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _menuItems.removeAt(oldIndex);
    _menuItems.insert(newIndex, item);
    
    // Update order values for all items
    for (var i = 0; i < _menuItems.length; i++) {
      _menuItems[i] = _menuItems[i].copyWith(order: i);
    }
    
    notifyListeners();
  }
} 