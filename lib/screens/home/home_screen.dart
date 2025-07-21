import 'package:flutter/material.dart';
import 'package:inmuno/config/routes/routes.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/screens/citas/citas_screen.dart';
import 'package:inmuno/screens/familia/familia_screen.dart';
import 'package:inmuno/screens/historial/historial_screen.dart';
import 'package:inmuno/screens/home/home_inicio.dart';
import 'package:inmuno/screens/home/widgets/bottom_navigation_home.dart';
import 'package:inmuno/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;

    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text('No se pudo cargar el usuario')),
      );
    }

    final bool esPadre = usuario.rolId == 3;
    final bool esEnfermero = usuario.rolId == 2;

    final internalPages = <String, Widget>{
      AppRoutes.inicio: InicioPage(usuario: usuario),
      AppRoutes.historial: const HistorialPage(),
      if (esPadre) AppRoutes.familia: const FamiliaPage(),
      if (esEnfermero) AppRoutes.citas: const AgendarPage(),
    };

    final tabs = internalPages.keys.toList();
    final currentRoute = tabs[_selectedIndex];
    final currentPage = internalPages[currentRoute]!;

    return Scaffold(
      body: Column(
        children: [
          CustomHeader(
            onProfileTap: () {
              Navigator.pushNamed(context, AppRoutes.perfil);
            },
          ),
          Expanded(child: currentPage),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Agenda',
          ),
          if (esPadre)
            const BottomNavigationBarItem(
              icon: Icon(Icons.family_restroom),
              label: 'Familia',
            ),
          if (esEnfermero)
            const BottomNavigationBarItem(
              icon: Icon(Icons.app_registration_outlined),
              label: 'Mis Citas',
            ),
        ],
      ),
    );
  }
}
