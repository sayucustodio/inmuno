import 'package:flutter/material.dart';

class FamiliaPage extends StatefulWidget {
  const FamiliaPage({super.key});

  @override
  State<FamiliaPage> createState() => _FamiliaPageState();
}

class _FamiliaPageState extends State<FamiliaPage> {
  final List<String> familiares = [];

  void _agregarFamiliar() {
    showDialog(
      context: context,
      builder: (context) {
        String nombre = '';
        return AlertDialog(
          title: const Text('Agregar familiar'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Nombre'),
            onChanged: (value) => nombre = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nombre.trim().isNotEmpty) {
                  setState(() => familiares.add(nombre.trim()));
                  Navigator.pop(context);
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: familiares.isEmpty
          ? const Center(child: Text('No has añadido familiares.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: familiares.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(familiares[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      setState(() => familiares.removeAt(index));
                    },
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarFamiliar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
