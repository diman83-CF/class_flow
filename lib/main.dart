import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'presentation/menu_item.dart';
import 'core/localization/localization_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize localization
  await LocalizationProvider.instance.initialize();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocalizationProvider.instance),
        ChangeNotifierProvider(
          create: (_) => MenuProvider()
            ..initializeMenuItems([
              MenuItem(
                id: 'home',
                title: 'Home',
                route: '/home',
                order: 0,
                icon: Icons.apps,
              ),
              MenuItem(
                id: 'activities',
                title: 'Activities',
                route: '/activities',
                order: 1,
                icon: Icons.layers,
              ),
              MenuItem(
                id: 'students',
                title: 'Students',
                route: '/students',
                order: 2,
                icon: Icons.airplanemode_active,
              ),
              MenuItem(
                id: 'trainers',
                title: 'Trainers',
                route: '/trainers',
                order: 3,
                icon: Icons.people,
              ),
              MenuItem(
                id: 'leads',
                title: 'Leads',
                route: '/leads',
                order: 4,
                icon: Icons.chat_bubble_outline,
              ),
            ]),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Update menu items with localized strings after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMenuItems();
    });
  }

  void _updateMenuItems() {
    final localizationProvider = LocalizationProvider.instance;
    final menuProvider = Provider.of<MenuProvider>(context, listen: false);
    
    menuProvider.initializeMenuItems([
      MenuItem(
        id: 'home',
        title: localizationProvider.home,
        route: '/home',
        order: 0,
        icon: Icons.apps,
      ),
      MenuItem(
        id: 'activities',
        title: localizationProvider.activities,
        route: '/activities',
        order: 1,
        icon: Icons.layers,
      ),
      MenuItem(
        id: 'students',
        title: localizationProvider.students,
        route: '/students',
        order: 2,
        icon: Icons.airplanemode_active,
      ),
      MenuItem(
        id: 'trainers',
        title: localizationProvider.trainers,
        route: '/trainers',
        order: 3,
        icon: Icons.people,
      ),
      MenuItem(
        id: 'leads',
        title: localizationProvider.leads,
        route: '/leads',
        order: 4,
        icon: Icons.chat_bubble_outline,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localizationProvider, child) {
        // Update menu items when language changes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _updateMenuItems();
        });
        
        return MaterialApp(
          title: localizationProvider.appTitle,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('he', ''), // Hebrew
          ],
          locale: Locale(localizationProvider.currentLanguage),
          initialRoute: '/home',
          routes: {
            '/home': (context) => const HomePage(),
            '/activities': (context) => const ActivitiesPage(),
            '/students': (context) => const StudentsPage(),
            '/trainers': (context) => const TrainersPage(),
            '/leads': (context) => const LeadsPage(),
          },
        );
      },
    );
  }
} 