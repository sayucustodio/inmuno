import 'package:flutter/material.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/screens/user/create/create_centro_salud_page.dart';
import 'package:inmuno/screens/user/create/create_user_page.dart';
import 'package:inmuno/screens/user/widgets/genero_selector_widget.dart';
import 'package:inmuno/screens/user/widgets/input_data_widget.dart';

import 'package:inmuno/utils/colors.dart';
import 'package:intl/intl.dart';

class FormularioDniWidget extends StatefulWidget {
  final int rolId;

  const FormularioDniWidget({super.key, required this.rolId});

  @override
  State<FormularioDniWidget> createState() => _FormularioDniWidgetState();
}

class _FormularioDniWidgetState extends State<FormularioDniWidget> {
  final _formKey = GlobalKey<FormState>();

  final _dniController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

  String? _sexoSeleccionado;
  DateTime? _fechaNacimiento;
  bool _mostrarErrorFecha = false;
  String? _mensajeDni;

  @override
  void dispose() {
    _dniController.dispose();
    _nombresController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFechaNacimiento(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryGreen,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fechaNacimiento = picked;
        _mostrarErrorFecha = false;
      });
    }
  }

  Future<void> _validarDni(String dni) async {
    if (dni.length == 8) {
      try {
        final result =
            await PersonaService().verificarExistenciaDatos(dni: dni);
        setState(() {
          _mensajeDni = result['dni_existe'] == true
              ? 'Este DNI ya está registrado'
              : null;
        });
      } catch (e) {
        print('Error al verificar existencia del DNI: $e');
        setState(() => _mensajeDni = null);
      }
    } else {
      setState(() => _mensajeDni = null);
    }
  }

  void _continuarRegistro() {
    final isValid = _formKey.currentState!.validate();
    final faltaFecha = _fechaNacimiento == null;
    final faltaSexo = _sexoSeleccionado == null;

    setState(() {
      _mostrarErrorFecha = faltaFecha;
    });

    if (isValid && !faltaFecha && !faltaSexo && _mensajeDni == null) {
      final datos = {
        'nombres': _nombresController.text,
        'apellidoPaterno': _apellidoPaternoController.text,
        'apellidoMaterno': _apellidoMaternoController.text,
        'dni': _dniController.text,
        'direccion': _direccionController.text,
        'telefono': _telefonoController.text,
        'sexo': _sexoSeleccionado,
        'fechaNacimiento': _fechaNacimiento!.toIso8601String(),
        'rolId': widget.rolId,
      };

      if (widget.rolId == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SeleccionarCentroSaludPage(datosPersona: datos),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RegistroDatosUsuarioPage(datosPersona: datos),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomInputTextField(
            icon: Icons.credit_card,
            label: 'DNI',
            controller: _dniController,
            inputType: TextInputType.number,
            maxLength: 8,
            errorText: _mensajeDni,
            onChanged: (value) {
              if (value.length == 8) {
                _validarDni(value);
              } else {
                setState(() => _mensajeDni = null);
              }
            },
            validator: (value) {
              if (value == null || value.length != 8) {
                return 'DNI inválido';
              }
              return null;
            },
          ),
          CustomInputTextField(
            icon: Icons.person_outline,
            label: 'Nombres',
            controller: _nombresController,
            validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
          ),
          Row(
            children: [
              Expanded(
                child: CustomInputTextField(
                  icon: Icons.person,
                  label: 'Apellido Paterno',
                  controller: _apellidoPaternoController,
                  validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomInputTextField(
                  icon: Icons.person,
                  label: 'Apellido Materno',
                  controller: _apellidoMaternoController,
                  validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
                ),
              ),
            ],
          ),
          CustomInputTextField(
            icon: Icons.home,
            label: 'Dirección',
            controller: _direccionController,
            validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
          ),
          CustomInputTextField(
            icon: Icons.phone,
            label: 'Teléfono',
            controller: _telefonoController,
            inputType: TextInputType.phone,
            validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
          ),
          Row(
            children: [
              Expanded(
                child: CustomDropdownField<String>(
                  icon: Icons.wc,
                  label: 'Sexo',
                  value: _sexoSeleccionado,
                  options: ['M', 'F'],
                  onChanged: (value) =>
                      setState(() => _sexoSeleccionado = value),
                  validator: (value) =>
                      value == null ? 'Selecciona un sexo' : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: AppColors.primaryGreen, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Nacimiento',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _seleccionarFechaNacimiento(context),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderGray),
                          ),
                          child: Text(
                            _fechaNacimiento == null
                                ? 'Seleccionar fecha'
                                : DateFormat('d MMMM yyyy', 'es')
                                    .format(_fechaNacimiento!),
                            style: TextStyle(
                              fontSize: 14,
                              color: _fechaNacimiento == null
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      if (_mostrarErrorFecha)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'Debe seleccionar una fecha',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _continuarRegistro,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.encabezado.first,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }
}
