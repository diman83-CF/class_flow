import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/providers/business_provider.dart';
import 'domain/entities/business.dart';
import 'presentation/widgets/dynamic_text.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/activities_page.dart';
import 'presentation/pages/students_page.dart';
import 'presentation/pages/trainers_page.dart';
import 'presentation/pages/leads_page.dart';
import 'presentation/providers/menu_provider.dart';
import 'domain/entities/menu_item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MenuProvider()
        ..initializeMenuItems([
          MenuItem(
            id: 'home',
            title: 'דף הבית',
            route: '/home',
            order: 0,
            icon: Icons.apps,
          ),
          MenuItem(
            id: 'activities',
            title: 'מסגרות',
            route: '/activities',
            order: 1,
            icon: Icons.layers,
          ),
          MenuItem(
            id: 'students',
            title: 'תלמידים',
            route: '/students',
            order: 2,
            icon: Icons.airplanemode_active,
          ),
          MenuItem(
            id: 'trainers',
            title: 'מאמנים',
            route: '/trainers',
            order: 3,
            icon: Icons.people,
          ),
          MenuItem(
            id: 'leads',
            title: 'לידים',
            route: '/leads',
            order: 4,
            icon: Icons.chat_bubble_outline,
          ),
        ]),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Training Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/activities': (context) => const ActivitiesPage(),
        '/students': (context) => const StudentsPage(),
        '/trainers': (context) => const TrainersPage(),
        '/leads': (context) => const LeadsPage(),
      },
    );
  }
} 