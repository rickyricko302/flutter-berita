import 'package:flutter/material.dart';
import 'package:udb_news/views/layouts/auth_layout.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          const Text(
            "Daftar",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Text("Masukan alamat email dan kata sandi"),
          const SizedBox(height: 32),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              hintText: "Alamat email",
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.1),
              hintText: "Kata sandi",
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {},
              child: const Text(
                "Daftar",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sudah mempunyai akun?"),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Login disini",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: kBottomNavigationBarHeight),
        ],
      ),
    );
  }
}
