// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inmuno/core/constants.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/data/services/auth_services.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/screens/user/create/create_rol_page.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
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
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(text: '¿No tienes una cuenta? '),
                    TextSpan(
                      text: 'Registra ahora',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreen,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SeleccionRolPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              CustomTextField(
                controller: _emailController,
                label: 'Correo electrónico',
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: 'Contraseña',
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primaryGreen,
                  ),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Olvidé mi contraseña',
                  style: TextStyle(
                      color: AppColors.primaryGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    final usuario = _emailController.text.trim();
                    final clave = _passwordController.text;

                    if (usuario.isEmpty || clave.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor completa todos los campos'),
                        ),
                      );
                      return;
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    );

                    try {
                      final authService = AuthService();
                      final usuarioModel =
                          await authService.login(usuario, clave);
                      await authService.guardarSesion(
                          usuarioModel.token!, usuarioModel.id);
                      await authService.guardarUsuario(usuarioModel);

                      final personaService = PersonaService();
                      final personaModel =
                          await personaService.getPersonaById(usuarioModel.id);
                      final hijosModel = await personaService
                          .getHijosConDetalles(usuarioModel.id);
                      final centrosaludmodel = await personaService
                          .getCentroSaludByUsuarioId(usuarioModel.id);

                      if (!mounted) return;

                      Provider.of<UsuarioProvider>(context, listen: false)
                          .setUsuario(usuarioModel);
                      Provider.of<PersonaProvider>(context, listen: false)
                          .setPersona(personaModel);
                      Provider.of<HijosProvider>(context, listen: false)
                          .setHijos(hijosModel);
                      if (centrosaludmodel != null) {
                        Provider.of<CentroSaludProvider>(context, listen: false)
                            .setcentrosalud(centrosaludmodel);
                      }

                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, '/home');
                    } catch (e) {
                      if (mounted) Navigator.of(context).pop();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al iniciar sesión: $e')),
                      );
                    }
                  },
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                        color: AppColors.backgroundWhite, fontSize: 18),
                  ),
                ),
              ),
              const Spacer(),
              const Divider(),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(AppConstants.whatsappUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalNonBrowserApplication,
                    );
                  } else {
                    if (await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No se pudo abrir WhatsApp Web')),
                    );
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.whatsapp,
                        color: AppColors.greenDark),
                    SizedBox(width: 8),
                    Text(
                      'Contáctanos',
                      style: TextStyle(
                        color: AppColors.greenDark,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
