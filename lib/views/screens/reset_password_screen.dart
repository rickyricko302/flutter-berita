import 'package:flutter/material.dart';
import 'package:udb_news/views/layouts/auth_layout.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: Column(
        children: [
          const Text(
            "Lupa Kata Sandi",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Text("Masukan alamat email untuk mereset sandi"),
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
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
              onPressed: () {},
              child: const Text(
                "Kirim Kode OTP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sudah ingat?"),
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
