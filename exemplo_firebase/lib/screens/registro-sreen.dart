
import 'package:exemplo_firebase/Service/auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // tela de registro com confirmação de senha
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              //campos do form
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                  validator: (value) {}
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              validator:  (value) {},
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
              ),
              validator: (value) {}),

              const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        _registrar();
                      },
                      child: Text('Registrar'),
                    ),
                  ])),
        ),
      ),
    );
  }

  Future<void> _registrar() async {
    if (_confirmPasswordController.text == _passwordController.text) {
      if (_formKey.currentState!.validate()) {
        _authService.registerWithEmail(
            _emailController.text, _confirmPasswordController.text);
            Navigator.pushNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preencha todos os campos'),
          ),
        );
        return null;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Senhas não conferem'),
        ),
      );
      return null;
    }
  }
}

            