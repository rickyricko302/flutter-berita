import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/app/routes/app_pages.dart';
import 'package:info_a1/core/util.dart';
import 'package:info_a1/shared_widgets/auth_layout.dart';
import 'package:info_a1/shared_widgets/button_primary.dart';
import 'package:info_a1/shared_widgets/password_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: AuthLayout(
        child: Column(
          children: [
            Text("Selamat Datang", style: displaySmall(context: context)),
            Text(
              "silakan login terlebih dahulu untuk melanjutkan",
              style: TextStyle(color: Colors.grey),
            ),
            Gap(40),
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            Gap(20),
            MyPasswordField(
              placeholder: "Password",
              textEditingController: controller.passwordController,
            ),
            Gap(36),
            Obx(
              () =>
                  controller.isLoading
                      ? CircularProgressIndicator()
                      : MyPrimaryButton(
                        text: "Masuk",
                        onPresss: () {
                          controller.doLogin();
                        },
                      ),
            ),
            Gap(20),
            Text("Atau"),
            Gap(20),
            Obx(
              () =>
                  controller.isGoogleLoading
                      ? CircularProgressIndicator()
                      : SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(
                              color: primaryColor(context: context),
                            ),
                          ),
                          onPressed: () {
                            controller.doGoogleLogin();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedGoogle,
                                color: secondaryColor(context: context),
                              ),
                              Gap(8),
                              Text(
                                "Masuk dengan akun Google",
                                style: TextStyle(
                                  color: primaryColor(context: context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            ),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum punya akun?", style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Text("Daftar disini"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
