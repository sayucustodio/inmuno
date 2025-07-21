// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmuno/config/routes/routes.dart';
import 'package:inmuno/data/services/persona_services.dart';
import 'package:inmuno/screens/user/widgets/input_data_widget.dart';
import 'package:inmuno/utils/colors.dart';
import 'package:inmuno/widgets/custom_dialog.dart';

class RegistroDatosUsuarioPage extends StatefulWidget {
  final Map<String, dynamic> datosPersona;

  const RegistroDatosUsuarioPage({super.key, required this.datosPersona});

  @override
  State<RegistroDatosUsuarioPage> createState() =>
      _RegistroDatosUsuarioPageState();
}

class _RegistroDatosUsuarioPageState extends State<RegistroDatosUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioController = TextEditingController();
  final _contraseniaController = TextEditingController();
  final _correoController = TextEditingController();

  bool _aceptaTerminos = false;
  bool _correoExiste = false;
  bool _usuarioExiste = false;
  int _passwordStrength = 0;

  @override
  void initState() {
    super.initState();

    _correoController.addListener(() async {
      final correo = _correoController.text.trim();
      if (correo.length >= 5 && correo.contains('@')) {
        final result =
            await PersonaService().verificarExistenciaDatos(correo: correo);
        setState(() => _correoExiste = result['correo_existe'] ?? false);
      }
    });

    _usuarioController.addListener(() async {
      final usuario = _usuarioController.text.trim();
      if (usuario.length >= 3) {
        final result =
            await PersonaService().verificarExistenciaDatos(usuario: usuario);
        setState(() => _usuarioExiste = result['usuario_existe'] ?? false);
      }
    });

    _contraseniaController.addListener(() {
      setState(() {
        _passwordStrength =
            _calcularFuerzaPassword(_contraseniaController.text);
      });
    });
  }

  int _calcularFuerzaPassword(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;
    return strength;
  }

  Color _obtenerColorBarra(int nivel) {
    switch (nivel) {
      case 1:
        return Colors.redAccent;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow.shade700;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey.shade300;
    }
  }

  String _obtenerTextoFuerza(int nivel) {
    switch (nivel) {
      case 1:
        return 'Muy débil';
      case 2:
        return 'Débil';
      case 3:
        return 'Media';
      case 4:
        return 'Fuerte';
      case 5:
        return 'Muy fuerte';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _usuarioController.dispose();
    _contraseniaController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  void _mostrarTerminos() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Términos y Condiciones'),
        content: const SingleChildScrollView(
          child: Text('Aquí tus términos...'),
        ),
        actions: [
          TextButton(
            child: const Text('Cerrar'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _registrarUsuario() async {
    if (_formKey.currentState!.validate() && _aceptaTerminos) {
      final request = {
        ...widget.datosPersona,
        "usuario": _usuarioController.text,
        "contrasenia": _contraseniaController.text,
        "correo": _correoController.text,
      };

      try {
        final usuarioId = await PersonaService().registrarUsuario(request);
        if (usuarioId != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => CustomSuccessDialog(
              title: '¡Registro exitoso!',
              message: 'Tu cuenta ha sido creada correctamente.\n',
              buttonText: 'Iniciar sesión',
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
            ),
          );

          // Esperar 3 segundos antes de forzar navegación
          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            Navigator.pop(context); // cerrar el diálogo
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } else if (!_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Debes aceptar los términos y condiciones')),
      );
    }
  }

  bool get _formCompleto {
    return _correoController.text.isNotEmpty &&
        _usuarioController.text.isNotEmpty &&
        _contraseniaController.text.length >= 6 &&
        !_correoExiste &&
        !_usuarioExiste &&
        _aceptaTerminos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FA),
      appBar: AppBar(title: const Text('Crear cuenta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información de la cuenta',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Ingresa tus datos para crear tu cuenta segura',
                      style: TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                    const SizedBox(height: 12),
                    CustomInputTextField(
                      icon: Icons.email_outlined,
                      label: 'Correo electrónico',
                      controller: _correoController,
                      inputType: TextInputType.emailAddress,
                      errorText: _correoExiste ? 'Correo ya registrado' : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        if (!value.contains('@')) return 'Correo inválido';
                        if (_correoExiste) return 'Correo ya registrado';
                        return null;
                      },
                    ),
                    CustomInputTextField(
                      icon: Icons.person_outline,
                      label: 'Nombre de usuario',
                      controller: _usuarioController,
                      errorText: _usuarioExiste ? 'Ya existe' : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo requerido';
                        }
                        if (_usuarioExiste) {
                          return 'Nombre de usuario ya existe';
                        }
                        return null;
                      },
                    ),
                    CustomInputTextField(
                      icon: Icons.lock_outline,
                      label: 'Contraseña',
                      controller: _contraseniaController,
                      inputType: TextInputType.visiblePassword,
                      isPassword: true,
                      validator: (value) => value != null && value.length < 8
                          ? 'Debe tener al menos 8 caracteres'
                          : null,
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: _passwordStrength / 5,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          _obtenerColorBarra(_passwordStrength)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _obtenerTextoFuerza(_passwordStrength),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: _obtenerColorBarra(_passwordStrength),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _aceptaTerminos,
                    onChanged: (v) =>
                        setState(() => _aceptaTerminos = v ?? false),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black87),
                        children: [
                          const TextSpan(text: 'Acepto los '),
                          TextSpan(
                            text: 'términos y condiciones',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _mostrarTerminos,
                          ),
                          const TextSpan(text: ' y la '),
                          TextSpan(
                            text: 'política de privacidad',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _mostrarTerminos,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (widget.datosPersona['rolId'] == 2)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade400),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.orange, size: 24),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Tu cuenta estará inactiva hasta que el centro de salud confirme tus datos.',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: _formCompleto ? _registrarUsuario : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _formCompleto
                      ? AppColors.primaryGreen
                      : Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Completar registro'),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: '¿Ya tienes una cuenta? ',
                    children: [
                      TextSpan(
                          text: 'Iniciar sesión',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pushReplacementNamed(
                                context, AppRoutes.login)),
                    ],
                  ),
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
