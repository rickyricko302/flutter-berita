import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/models/user_model.dart';
import 'package:udb_news/providers/controllers/login/login_controller.dart';
import 'package:udb_news/providers/controllers/login/remember_me.dart';
import 'package:udb_news/views/layouts/auth_layout.dart';
import 'package:udb_news/views/screens/home_screen.dart';
import 'package:udb_news/views/screens/register_screen.dart';
import 'package:udb_news/views/screens/reset_password_screen.dart';
import 'package:udb_news/views/shared_widgets/alert_error.dart';
import 'package:udb_news/views/shared_widgets/button.dart';
import 'package:udb_news/views/shared_widgets/password_field.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/views/shared_widgets/text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final ProviderSubscription loginListener;

  @override
  void initState() {
    super.initState();
    loginListener = ref.listenManual<AsyncValue<UserModel?>>(
      loginControllerProvider,
      (previous, next) {
        next.whenOrNull(
          data: (data) {
            if (data != null) {
              Helper.pushPage(
                context: context,
                page: HomeScreen(nama: data.firstName.toString()),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginController = ref.watch(loginControllerProvider);
    final loginControllerNotifier = ref.read(loginControllerProvider.notifier);
    final rememberMeNotifier = ref.read(rememberMeProvider.notifier);
    final isRememberMe = ref.watch(rememberMeProvider);
    final bool isLoading = loginController.isLoading;
    final String? messageError = loginController.whenOrNull(
      error: (error, stackTrace) => error.toString(),
    );
    return AuthLayout(
      child: Column(
        children: [
          if (messageError != null) MyAlertError(message: messageError),
          const Text(
            "Masuk",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Text("Masukan alamat email dan kata sandi"),
          const SizedBox(height: 32),
          MyTextField(
            hint: "Alamat email",
            textEditingController: _emailController,
          ),
          const SizedBox(height: 12),
          MyPasswordField(
            textEditingController: _passwordController,
            placeholder: 'Kata sandi',
          ),
          Row(
            children: [
              Checkbox(
                value: isRememberMe,
                onChanged: (isCheck) {
                  rememberMeNotifier.toggle();
                },
                visualDensity: VisualDensity.compact,
                side: BorderSide(color: Colors.grey, width: 2),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    rememberMeNotifier.toggle();
                  },
                  child: Text("Ingat saya"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Helper.pushPage(
                    context: context,
                    page: ResetPasswordScreen(),
                  );
                },
                child: const Text(
                  "Lupa kata sandi?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: MyButtonPrimary(
              onPress:
                  isLoading
                      ? null
                      : () {
                        final String email = _emailController.text;
                        final String password = _passwordController.text;
                        loginControllerNotifier.login(
                          email: email,
                          password: password,
                          isRememberMe: isRememberMe,
                        );
                      },
              text: "Masuk",
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Belum mempunyai akun?"),
              TextButton(
                onPressed: () {
                  Helper.pushPage(context: context, page: RegisterScreen());
                },
                child: const Text(
                  "Daftar disini",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    loginListener.close();
    super.dispose();
  }
}
