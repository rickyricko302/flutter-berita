import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:info_a1/shared_widgets/button_primary.dart';
import 'package:info_a1/shared_widgets/text_field.dart';

import '../../../../core/util.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(context: context),
      appBar: AppBar(
        title: Text('Profil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: primaryColor(context: context),
      ),
      body: Obx(
        () =>
            controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                  onRefresh: () async {
                    await controller.getProfile();
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: primaryColor(context: context),
                          padding: EdgeInsets.only(bottom: 60, top: 40),
                          child: Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                    controller.profileModel.photoPath ??
                                        "https://avatar.iran.liara.run/public/1",
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: IconButton(
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      controller.uploadImage();
                                    },
                                    icon: HugeIcon(
                                      icon: HugeIcons.strokeRoundedPencilEdit01,
                                      color: secondaryColor(context: context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyTextField(
                                customBackground: Colors.white,
                                controller: controller.nameController,
                                label: "Nama",
                              ),
                              Gap(28),
                              MyTextField(
                                customBackground: Colors.white,
                                controller: controller.phoneController,
                                keyboardType: TextInputType.number,
                                label: "Nomor Telepon",
                              ),
                              Gap(28),
                              TextField(
                                controller: controller.addressController,
                                minLines: 4,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  labelText: "Alamat",
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Gap(40),
                              Obx(
                                () =>
                                    controller.isLoadingUpdate
                                        ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                        : MyPrimaryButton(
                                          text: "Simpan",
                                          onPresss: () {
                                            controller.updateProfile();
                                          },
                                        ),
                              ),
                              Gap(20),
                              Center(
                                child: IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    controller.logout();
                                  },
                                  icon: HugeIcon(
                                    icon: HugeIcons.strokeRoundedLogout04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
