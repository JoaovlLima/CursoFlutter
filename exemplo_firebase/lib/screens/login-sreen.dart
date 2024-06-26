import 'package:exemplo_firebase/Service/auth_service.dart';
import 'package:exemplo_firebase/screens/todolist_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira uma senha';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){_validarLogin();}, 
                  child: const Text("Logar"),)
              ],
            ),
          ),
        ),
      )
    );
  }

Future<void> _validarLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        User? user = await _authService.signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );
        if (user != null){
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(
            builder: (context)=>TodolistScreen(user:user)));}
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Usuário ou senha inválidos"),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }
  }
}