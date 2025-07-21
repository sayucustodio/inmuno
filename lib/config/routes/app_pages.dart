import 'package:flutter/material.dart';
import 'package:inmuno/config/routes/routes.dart';
import 'package:inmuno/screens/auth/auth_screen.dart';
import 'package:inmuno/screens/citas/citas_screen.dart';
import 'package:inmuno/screens/familia/familia_screen.dart';
import 'package:inmuno/screens/historial/historial_screen.dart';
import 'package:inmuno/screens/home/home_screen.dart';
import 'package:inmuno/screens/perfil/perfil_screen.dart';
import 'package:inmuno/splashcreen.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.login: (_) => const LoginScreen(),
    AppRoutes.home: (_) => const HomeScreen(),
    AppRoutes.historial: (_) => const HistorialPage(),
    AppRoutes.familia: (_) => const FamiliaPage(),
    AppRoutes.perfil: (_) => const PerfilScreen(),
    AppRoutes.splash: (_) => const SplashScreen(),
    AppRoutes.citas: (_) => const AgendarPage()
  };
}
