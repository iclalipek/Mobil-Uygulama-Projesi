import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/components/input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found' && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kullanıcı bulunamadı'),
            ),
          );
        } else if (e.code == 'invalid-credential' && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Şifre yanlış'),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bir hata oluştu'),
            ),
          );
        }
      }
    }
  }

  String? validateUsername(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Kullanıcı adı boş bırakılamaz';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Şifre boş bırakılamaz';
    }
    return null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Hoşgeldiniz",
                  style: TextStyle(
                    fontSize: 42,
                  )),
              const SizedBox(height: 20),
              Input(controller: usernameController, label: "Email"),
              const SizedBox(height: 10),
              Input(
                controller: passwordController,
                label: "Şifre",
                obscureText: obscureText,
                suffixIcon:
                    obscureText ? Icons.visibility : Icons.visibility_off,
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: const Text('Giriş'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
