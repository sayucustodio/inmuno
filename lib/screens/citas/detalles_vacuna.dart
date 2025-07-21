import 'package:flutter/material.dart';
import 'package:inmuno/data/models/vacuna_esquema_model.dart';

class DetalleVacunasPage extends StatelessWidget {
  final String titulo;
  final List<VacunaEsquemaModel> vacunas;

  const DetalleVacunasPage({
    super.key,
    required this.titulo,
    required this.vacunas,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, List<VacunaEsquemaModel>> vacunasPorNombre = {};

    for (var vacuna in vacunas) {
      vacunasPorNombre.putIfAbsent(vacuna.nombre, () => []);
      vacunasPorNombre[vacuna.nombre]!.add(vacuna);
    }

    // Ordenar las vacunas dentro de cada grupo por edad mínima
    for (var lista in vacunasPorNombre.values) {
      lista
          .sort((a, b) => a.edad_minima_meses!.compareTo(b.edad_minima_meses!));
    }

    // Ordenar los nombres alfabéticamente
    final nombresOrdenados = vacunasPorNombre.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: nombresOrdenados.length,
        itemBuilder: (context, index) {
          final nombre = nombresOrdenados[index];
          final dosisList = vacunasPorNombre[nombre]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              ...dosisList.map((vacuna) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (vacuna.descripcion != null)
                          Text("Descripción: ${vacuna.descripcion!}"),
                        Text("Dosis: ${vacuna.dosis}"),
                        Text("Vía: ${vacuna.via}"),
                        Text("Orden: ${vacuna.dosis_orden}"),
                        Text("Edad mínima: ${vacuna.edad_minima_meses} meses"),
                        if (vacuna.edad_maxima_meses != null)
                          Text(
                              "Edad máxima: ${vacuna.edad_maxima_meses} meses"),
                      ],
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
