import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udb_news/providers/controllers/profile/profile_controller.dart';
import 'package:udb_news/views/shared_widgets/alert_error.dart';
import 'package:udb_news/views/shared_widgets/button.dart';
import 'package:udb_news/views/shared_widgets/custom_app_bar.dart';
import 'package:udb_news/views/shared_widgets/text_field.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.nama});
  final String nama;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      ref.read(profileControllerProvider.notifier).getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileController = ref.watch(profileControllerProvider);
    final profileNotifier = ref.read(profileControllerProvider.notifier);
    return Scaffold(
      appBar: CustomAppbar(title: 'Home Screen', leading: SizedBox()),
      body: SafeArea(
        child: profileController.when(
          data: (data) => _buildOnData(context, profileNotifier, data),
          error: (error, stackTrace) => _buildOnError(error),
          loading: () => _buildOnLoading(),
        ),
      ),
    );
  }

  Widget _buildOnData(context, ProfileController profileController, data) {
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
                      'Ricky Verdiyanto',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '20 Tahun',
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
                textEditingController: TextEditingController(text: "ricky"),
                prefix: Icon(Icons.person_outline, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Email', style: TextStyle(color: Colors.grey)),
              MyTextField(
                textEditingController: TextEditingController(
                  text: "verdiyantorky123@gmail.com",
                ),
                prefix: Icon(Icons.mail_outline, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('No Telepon', style: TextStyle(color: Colors.grey)),
              MyTextField(
                textEditingController: TextEditingController(
                  text: "6289503932319",
                ),
                prefix: Icon(Icons.phone_outlined, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Tanggal Lahir', style: TextStyle(color: Colors.grey)),
              MyTextField(
                textEditingController: TextEditingController(
                  text: "19 Desember 2003",
                ),
                prefix: Icon(Icons.date_range_outlined, color: Colors.purple),
              ),
              const SizedBox(height: 20),
              Text('Alamat', style: TextStyle(color: Colors.grey)),
              MyTextField(
                textEditingController: TextEditingController(
                  text: "Bonangan RT 06/07 Baturan, Colomadu, Karanganyar",
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnError(error) {
    return Center(child: MyAlertError(message: error.toString()));
  }

  Widget _buildOnLoading() {
    return Center(child: CircularProgressIndicator());
  }
}
