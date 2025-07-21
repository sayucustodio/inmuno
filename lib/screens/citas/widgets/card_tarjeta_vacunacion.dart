import 'package:flutter/material.dart';
import 'package:inmuno/data/models/vacuna_esquema_model.dart';
import 'package:inmuno/data/services/vacuna_service.dart';
import 'package:inmuno/screens/citas/detalles_vacuna.dart';
import 'package:inmuno/screens/citas/widgets/card_design_vacuna.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/utils/functions.dart';

class ListaTarjetasVacunacion extends StatelessWidget {
  final int edadEnMeses;
  const ListaTarjetasVacunacion({super.key, required this.edadEnMeses});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VacunaEsquemaModel>>(
      future: VacunaService().getVacunasConEsquema(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final vacunasDisponibles = snapshot.data!
            .where((v) =>
                v.edad_minima_meses != null &&
                v.edad_minima_meses! <= edadEnMeses)
            .toList();

        final Map<String, List<VacunaEsquemaModel>> grupos = {};

        for (var vacuna in vacunasDisponibles) {
          final grupo = RolUtils.getGrupoEdad(vacuna.edad_minima_meses!);
          grupos.putIfAbsent(grupo, () => []);
          grupos[grupo]!.add(vacuna);
        }

        final colores = [
          [AppColors.tarjetaRosa1, AppColors.tarjetaRosa2],
          [AppColors.tarjetaAzul1, AppColors.tarjetaAzul2],
          [AppColors.tarjetaMorado1, AppColors.tarjetaMorado2],
          [AppColors.tarjetaVerde1, AppColors.tarjetaVerde2],
          [AppColors.tarjetaAmarilla1, AppColors.tarjetaAmarilla2],
        ];

        final iconos = [
          Icons.child_care,
          Icons.baby_changing_station,
          Icons.vaccines,
          Icons.local_hospital,
          Icons.shield,
        ];

        final List<Widget> tarjetas = [];
        int index = 0;

        for (var entry in grupos.entries) {
          final color1 = colores[index % colores.length][0];
          final color2 = colores[index % colores.length][1];
          final icono = iconos[index % iconos.length];
          final nombres = entry.value.map((e) => e.nombre).toList();
          final vacunas = entry.value;

          tarjetas.add(
            WidgetDesignCardVacuna(
              titulo: entry.key,
              vacunas: nombres,
              color1: color1,
              color2: color2,
              icono: icono,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalleVacunasPage(
                      titulo: entry.key,
                      vacunas: vacunas,
                    ),
                  ),
                );
              },
            ),
          );

          index++;
        }

        if (tarjetas.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No hay vacunas programadas para la edad actual.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return Column(children: tarjetas);
      },
    );
  }
}
