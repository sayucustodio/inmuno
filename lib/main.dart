import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inmuno/config/providers/app_providers.dart';
import 'package:inmuno/config/routes/app_pages.dart';
import 'package:inmuno/config/routes/routes.dart';
import 'package:inmuno/config/theme/app_theme.dart';

void main() {
  runApp(const AppProviders());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vacunas App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // Español
      ],
      locale: const Locale('es', 'ES'),
      routes: AppPages.routes,
      theme: AppTheme.theme,
    );
  }
}
