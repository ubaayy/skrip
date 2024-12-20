import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.onLogin}) : super(key: key);
  final Function(String, String) onLogin; // Fungsi callback untuk login
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>(); // key untuk form validasi

  void _showConfirmationDialog(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('konfirmasi'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); //Tutup dialog
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  // Fungsi untuk Validasi form dan login
  void _validateAndLogin() {
    if (_formkey.currentState!.validate()) {
      String username = usernameController.text;
      String password = passwordcontroller.text;

      if (username == "admin" && password == "admin123") {
        widget.onLogin(username, password); // panggil fungsi login
        _showConfirmationDialog('Login berhasil!');
      } else {
        _showConfirmationDialog('username atau password salah!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan username",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'password tidak boleh kosong';
                } else if (value.length < 6) {
                  return 'password harus lebih dari 6 karakter';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: _validateAndLogin,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
