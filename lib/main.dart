import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'services/data_service.dart';
import 'screens/welcome_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/court_detail_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/admin/admin_home_screen.dart';
import 'screens/admin/add_edit_court_screen.dart';
import 'models/court.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataService()),
      ],
      child: MaterialApp(
        title: 'Kinglap',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2b8cee),
            primary: const Color(0xFF2b8cee),
            background: const Color(0xFFf6f7f8),
            brightness: Brightness.light,
          ),
          fontFamily: GoogleFonts.lexend().fontFamily,
          scaffoldBackgroundColor: const Color(0xFFf6f7f8),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFf6f7f8),
            surfaceTintColor: Colors.transparent,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2b8cee),
            primary: const Color(0xFF2b8cee),
            background: const Color(0xFF101922),
            brightness: Brightness.dark,
          ),
          fontFamily: GoogleFonts.lexend().fontFamily,
          scaffoldBackgroundColor: const Color(0xFF101922),
           appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF101922),
            surfaceTintColor: Colors.transparent,
             foregroundColor: Colors.white,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WelcomeScreen(),
          '/auth': (context) => const AuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/admin_home': (context) => const AdminHomeScreen(),
          '/admin/add_edit_court': (context) {
             final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
             return AddEditCourtScreen(court: args?['court'] as Court?);
          }
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/court_detail') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CourtDetailScreen(courtId: args['courtId']),
            );
          }
           if (settings.name == '/booking') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => BookingScreen(courtId: args['courtId']),
            );
          }
          return null;
        },
      ),
    );
  }
}
