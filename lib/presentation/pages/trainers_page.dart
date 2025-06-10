import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/business_provider.dart';
import '../../domain/entities/business.dart';
import '../widgets/dynamic_text.dart';
import '../widgets/side_menu.dart';
import '../providers/menu_provider.dart';
import '../widgets/language_selector.dart';
import '../../core/localization/localization_provider.dart';

class TrainersPage extends StatefulWidget {
  const TrainersPage({super.key});

  @override
  State<TrainersPage> createState() => _TrainersPageState();
}

class _TrainersPageState extends State<TrainersPage> {
  Business? _firstBusiness;

  @override
  void initState() {
    super.initState();
    _loadFirstBusiness();
  }

  Future<void> _loadFirstBusiness() async {
    final business = await BusinessProvider.getFirstBusiness();
    if (mounted) {
      setState(() {
        _firstBusiness = business;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: DynamicText<Business?>(
          object: _firstBusiness,
          staticText: localizationProvider.translate('trainers.title'),
          style: const TextStyle(fontSize: 20),
          textExtractor: (business) => business?.name ?? localizationProvider.translate('trainers.title'),
        ),
        actions: [
          const LanguageSelector(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: localizationProvider.textDirection,
        child: Stack(
          children: [
            // Main content
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: !isMobile && localizationProvider.isLTR ? 250 : 0,
                  right: !isMobile && localizationProvider.isRTL ? 250 : 0,
                ),
                child: Column(
                  children: [
                    // Search and filter bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: localizationProvider.translate('trainers.search_placeholder'),
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onChanged: (value) {
                                // TODO: Implement search
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.filter_list),
                            onSelected: (value) {
                              // TODO: Implement filtering
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'all',
                                child: Text(localizationProvider.translate('trainers.filter.all')),
                              ),
                              PopupMenuItem(
                                value: 'active',
                                child: Text(localizationProvider.translate('trainers.filter.active')),
                              ),
                              PopupMenuItem(
                                value: 'inactive',
                                child: Text(localizationProvider.translate('trainers.filter.inactive')),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Trainers content
                    Expanded(
                      child: Center(
                        child: Text(
                          localizationProvider.translate('trainers.no_trainers_found'),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                          textAlign: localizationProvider.isRTL ? TextAlign.right : TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Side menu for LTR (left side)
            if (!isMobile && localizationProvider.isLTR)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: SideMenu(
                  menuItems: menuProvider.menuItems,
                  selectedRoute: menuProvider.currentRoute,
                  onNavigate: (route) {
                    menuProvider.setCurrentRoute(route);
                    Navigator.of(context).pushReplacementNamed(route);
                  },
                ),
              ),
            
            // Side menu for RTL (right side)
            if (!isMobile && localizationProvider.isRTL)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SideMenu(
                  menuItems: menuProvider.menuItems,
                  selectedRoute: menuProvider.currentRoute,
                  onNavigate: (route) {
                    menuProvider.setCurrentRoute(route);
                    Navigator.of(context).pushReplacementNamed(route);
                  },
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: isMobile
          ? NavigationBar(
              selectedIndex: 2, // Trainers
              onDestinationSelected: (index) {
                final routes = ['/activities', '/students', '/trainers', '/leads'];
                menuProvider.setCurrentRoute(routes[index]);
                Navigator.of(context).pushReplacementNamed(routes[index]);
              },
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.calendar_today),
                  label: localizationProvider.activities,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.people),
                  label: localizationProvider.students,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.school),
                  label: localizationProvider.trainers,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.leaderboard),
                  label: localizationProvider.leads,
                ),
              ],
            )
          : null,
    );
  }
} 