import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../menu_item.dart';
import '../../core/localization/localization_provider.dart';

class SideMenu extends StatelessWidget {
  final List<MenuItem> menuItems;
  final Function(String route) onNavigate;
  final String? selectedRoute;
  final double width;
  final Color? backgroundColor;
  final TextStyle? itemTextStyle;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color activeBarColor;
  final Color activeBackgroundColor;

  const SideMenu({
    super.key,
    required this.menuItems,
    required this.onNavigate,
    this.selectedRoute,
    this.width = 250,
    this.backgroundColor,
    this.itemTextStyle,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.activeBarColor = const Color(0xFF2979FF), // Blue
    this.activeBackgroundColor = const Color(0xFFF1F6FE), // Light blue
  });

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    
    // Sort menu items by order and filter visible items
    final sortedItems = menuItems
        .where((item) => item.isVisible)
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    return Container(
      width: width,
      color: backgroundColor ?? Theme.of(context).drawerTheme.backgroundColor ?? Colors.white,
      child: Directionality(
        textDirection: localizationProvider.textDirection,
        child: ListView.builder(
          itemCount: sortedItems.length,
          itemBuilder: (context, index) {
            final item = sortedItems[index];
            final isSelected = item.route == selectedRoute;
            return Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? activeBackgroundColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: item.icon != null
                        ? Icon(
                            item.icon,
                            color: isSelected ? activeBarColor : unselectedItemColor ?? Colors.grey,
                          )
                        : null,
                    title: Text(
                      item.title,
                      style: itemTextStyle?.copyWith(
                            color: isSelected ? activeBarColor : unselectedItemColor ?? Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ) ??
                          TextStyle(
                            color: isSelected ? activeBarColor : unselectedItemColor ?? Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                      textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
                    ),
                    onTap: () => onNavigate(item.route),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                if (isSelected)
                  Positioned(
                    right: localizationProvider.isRTL ? null : 0,
                    left: localizationProvider.isRTL ? 0 : null,
                    top: 8,
                    bottom: 8,
                    child: Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: activeBarColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
} 