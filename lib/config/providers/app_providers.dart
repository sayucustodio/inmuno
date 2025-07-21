import 'package:flutter/material.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/main.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioProvider()),
        ChangeNotifierProvider(create: (_) => PersonaProvider()),
        ChangeNotifierProvider(create: (_) => HijosProvider()),
        ChangeNotifierProvider(create: (_) => CentroSaludProvider()),
      ],
      child: const MyApp(),
    );
  }
}
