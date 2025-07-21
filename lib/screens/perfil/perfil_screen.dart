// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inmuno/data/providers/centro_salud_provider.dart';
import 'package:inmuno/data/providers/hijos_provider.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/screens/centro_salud/centro_screen.dart';
import 'package:inmuno/screens/perfil/perfil_resume_screen.dart';
import 'package:inmuno/screens/perfil/widgets/custom_tile_perfil.dart';
import 'package:inmuno/screens/perfil/widgets/header_perfil.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/utils/functions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    final persona = Provider.of<PersonaProvider>(context).persona;

    final List<Widget> ayudaItems = [
      CustomPerfilListTile(
        leading: const Icon(Icons.help_outline, color: AppColors.primaryGreen),
        title: 'Preguntas frecuentes',
        onTap: () {},
      ),
      CustomPerfilListTile(
        leading: const FaIcon(FontAwesomeIcons.whatsapp,
            color: AppColors.primaryGreen),
        title: 'WhatsApp Inmuno',
        onTap: () {},
      ),
      CustomPerfilListTile(
        leading:
            const Icon(Icons.article_outlined, color: AppColors.primaryGreen),
        title: 'Términos y condiciones',
        onTap: () {},
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: ListView(
        children: [
          HeaderPerfil(
            nombreUsuario: RolUtils.obtenerNombreCompleto(
              nombres: persona?.nombres,
              apellidoPaterno: persona?.apellidoPaterno,
              apellidoMaterno: persona?.apellidoMaterno,
            ),
            onClose: () => Navigator.pop(context),
          ),
          ListTile(
            title: const Text('Perfil'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PerfilPage()),
              );
            },
          ),
          if (usuario?.rolId == 2 || usuario?.rolId == 1)
            ListTile(
              title: const Text('Clínica'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CentroSaludScreen(),
                  ),
                );
              },
            ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '¿Tienes alguna duda o inconveniente?',
              style: TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          ...ayudaItems,
          ListTile(
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Provider.of<UsuarioProvider>(context, listen: false)
                  .clearUsuario();
              Provider.of<PersonaProvider>(context, listen: false)
                  .clearPersona();
              Provider.of<HijosProvider>(context, listen: false).clearHijos();
              Provider.of<CentroSaludProvider>(context, listen: false)
                  .clearcentrosalud();

              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              await prefs.remove('userId');

              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Center(
              child: Text(
                'v. Versión 0.1.1',
                style: TextStyle(fontSize: 12, color: Colors.black38),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
