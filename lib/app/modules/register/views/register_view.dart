import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:info_a1/shared_widgets/text_field.dart';

import '../../../../core/util.dart';
import '../../../../shared_widgets/auth_layout.dart';
import '../../../../shared_widgets/button_primary.dart';
import '../../../../shared_widgets/password_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: AuthLayout(
        child: Column(
          children: [
            Text("Daftar Akun", style: displaySmall(context: context)),
            Text(
              "silakan isi form untuk mendaftar",
              style: TextStyle(color: Colors.grey),
            ),
            Gap(40),
            MyTextField(
              controller: controller.nameController,
              label: "Nama Lengkap",
            ),
            Gap(20),
            MyTextField(
              controller: controller.emailController,
              label: "Email",
              keyboardType: TextInputType.emailAddress,
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
                          controller.register();
                        },
                      ),
            ),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" punya akun?", style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Login disini"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
