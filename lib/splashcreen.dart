// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inmuno/data/models/usuario_model.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final jsonString = prefs.getString('usuario');

    if (token != null && jsonString != null) {
      try {
        final usuarioJson = jsonDecode(jsonString);
        final usuarioModel = UsuarioModel.fromJson(usuarioJson);

        final personaService = PersonaService();
        final personaModel =
            await personaService.getPersonaById(usuarioModel.id);
        final hijosModel =
            await personaService.getHijosConDetalles(usuarioModel.id);
        final centroSaludModel =
            await personaService.getCentroSaludByUsuarioId(usuarioModel.id);

        if (!mounted) return;

        Provider.of<UsuarioProvider>(context, listen: false)
            .setUsuario(usuarioModel);
        Provider.of<PersonaProvider>(context, listen: false)
            .setPersona(personaModel);
        Provider.of<HijosProvider>(context, listen: false).setHijos(hijosModel);
        if (centroSaludModel != null) {
          Provider.of<CentroSaludProvider>(context, listen: false)
              .setcentrosalud(centroSaludModel);
        }

        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'IN',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  TextSpan(
                    text: 'MU',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.darkText,
                    ),
                  ),
                  TextSpan(
                    text: 'NO',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: AppColors.primaryGreen,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingresando',
              style: TextStyle(
                color: AppColors.darkText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
