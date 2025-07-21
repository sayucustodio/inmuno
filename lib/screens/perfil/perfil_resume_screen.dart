import 'package:flutter/material.dart';
import 'package:inmuno/data/providers/persona_provider.dart';
import 'package:inmuno/data/providers/usuario_provider.dart';
import 'package:inmuno/data/request/persona_request.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/screens/perfil/widgets/perfil_build_input.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/utils/functions.dart';
import 'package:inmuno/widgets/header_perfil_general.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  bool isEditing = false;
  final nombresController = TextEditingController();
  final apellidoPaternoController = TextEditingController();
  final apellidoMaternoController = TextEditingController();
  final correoController = TextEditingController();
  final telefonoController = TextEditingController();
  final direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UsuarioProvider>(context).usuario;
    final persona = Provider.of<PersonaProvider>(context).persona;

    late final String nombre = RolUtils.obtenerNombreCompleto(
      nombres: persona?.nombres,
      apellidoPaterno: persona?.apellidoPaterno,
      apellidoMaterno: persona?.apellidoMaterno,
    );

    late final String rolNombre =
        RolUtils.obtenerNombreRol(usuario?.rolId, persona?.sexo);

    late final String fechaNacimiento = persona?.fechaNacimiento != null
        ? DateFormat('dd/MM/yyyy').format(persona!.fechaNacimiento!)
        : 'Fecha no disponible';

    if (!isEditing) {
      nombresController.text = persona?.nombres ?? '';
      apellidoPaternoController.text = persona?.apellidoPaterno ?? '';
      apellidoMaternoController.text = persona?.apellidoMaterno ?? '';
      correoController.text = usuario?.usuario ?? '';
      telefonoController.text = persona?.telefono ?? '';
      direccionController.text = persona?.direccion ?? '';
    }

    final inputs = [
      PerfilBuildInput.buildInputWithController(
        'Nombres',
        nombresController,
        icon: Icons.person,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInputWithController(
        'Apellido Paterno',
        apellidoPaternoController,
        icon: Icons.person_outline,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInputWithController(
        'Apellido Materno',
        apellidoMaternoController,
        icon: Icons.person_outline,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInputWithController(
        'Correo electrónico',
        correoController,
        icon: Icons.email_outlined,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInputWithController(
        'Teléfono',
        telefonoController,
        icon: Icons.phone,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInput(
        'Documento de identidad',
        persona?.dni ?? '',
        icon: Icons.badge_outlined,
        editable: false,
      ),
      PerfilBuildInput.buildInputWithController(
        'Dirección',
        direccionController,
        icon: Icons.location_on_outlined,
        editable: isEditing,
      ),
      PerfilBuildInput.buildInput(
        'Fecha de nacimiento',
        fechaNacimiento,
        icon: Icons.calendar_today_outlined,
        editable: false,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: AppColors.encabezado,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  HeaderPerfilGeneral(
                    icon: Icons.person,
                    titulo: nombre,
                    subtitulo: rolNombre,
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16),
                child: PerfilWidgets.buildInfoCard(
                  'Información Personal',
                  inputs,
                  onEdit: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ),
              if (isEditing)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        final request = UsuarioUpdateRequest(
                          usuarioId: usuario!.id,
                          nombres: nombresController.text.trim(),
                          apellidoPaterno:
                              apellidoPaternoController.text.trim(),
                          apellidoMaterno:
                              apellidoMaternoController.text.trim(),
                          correo: correoController.text.trim(),
                          telefono: telefonoController.text.trim(),
                          direccion: direccionController.text.trim(),
                        );

                        await PersonaService().editarDatosPersona(request);

                        await Provider.of<PersonaProvider>(context,
                                listen: false)
                            .updatePersona(usuario.id);

                        if (mounted) {
                          setState(() => isEditing = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Datos actualizados correctamente'),
                            ),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar cambios'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
              const SizedBox(height: 25),
            ]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nombresController.dispose();
    apellidoPaternoController.dispose();
    apellidoMaternoController.dispose();
    correoController.dispose();
    telefonoController.dispose();
    direccionController.dispose();
    super.dispose();
  }
}
