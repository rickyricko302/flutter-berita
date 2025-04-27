import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/core/models/profile_model.dart';
import 'package:udb_news/providers/controllers/profile/profile_controller.dart';
import 'package:udb_news/views/shared_widgets/alert_error.dart';
import 'package:udb_news/views/shared_widgets/button.dart';
import 'package:udb_news/views/shared_widgets/custom_app_bar.dart';
import 'package:udb_news/views/shared_widgets/text_field.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key, required this.nama});
  final String nama;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      final profileNotifier = ref.read(profileControllerProvider.notifier);
      profileNotifier.getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final profileNotifier = ref.read(profileControllerProvider.notifier);
    return Scaffold(
      appBar: CustomAppbar(title: 'Profil Saya', leading: SizedBox()),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: profileController.when(
            data: (data) {
              if (data != null) {
                return _buildOnData(context, profileNotifier, data);
              }
              return _buildOnLoading();
            },
            error: (error, stackTrace) => _buildOnError(error),
            loading: () => _buildOnLoading(),
          ),
        ),
      ),
    );
  }

  Widget _buildOnData(
    context,
    ProfileController profileController,
    ProfileModel data,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        await profileController.getProfile();
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 72,
                      backgroundImage: NetworkImage(
                        "https://dummyjson.com/icon/emilys/128",
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${data.firstName} ${data.maidenName} ${data.lastName}",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${data.age} Tahun',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text('Username', style: TextStyle(color: Colors.grey)),
              MyTextField(
                enabled: false,
                textEditingController: TextEditingController(
                  text: data.username,
                ),
                prefix: Icon(Icons.person_outline, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Email', style: TextStyle(color: Colors.grey)),
              MyTextField(
                enabled: false,
                textEditingController: TextEditingController(text: data.email),
                prefix: Icon(Icons.mail_outline, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('No Telepon', style: TextStyle(color: Colors.grey)),
              MyTextField(
                enabled: false,
                textEditingController: TextEditingController(text: data.phone),
                prefix: Icon(Icons.phone_outlined, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Tanggal Lahir', style: TextStyle(color: Colors.grey)),
              MyTextField(
                enabled: false,
                textEditingController: TextEditingController(
                  text: data.birthDate,
                ),
                prefix: Icon(Icons.date_range_outlined, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Alamat', style: TextStyle(color: Colors.grey)),
              MyTextField(
                enabled: false,
                textEditingController: TextEditingController(
                  text:
                      "${data.address?.address}, ${data.address?.city}, ${data.address?.country}",
                ),
                maxLine: 3,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: MyButtonPrimary(
                  onPress: () {
                    profileController.logout(context: context);
                  },
                  text: 'Keluar',
                ),
              ),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnError(error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAlertError(message: error.toString()),
          IconButton(
            onPressed: () {
              ref.read(profileControllerProvider.notifier).getProfile();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildOnLoading() {
    return Center(child: CircularProgressIndicator());
  }
}
