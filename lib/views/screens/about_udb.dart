import 'package:flutter/material.dart';
import 'package:udb_news/core/utils/helper.dart';
import 'package:udb_news/views/shared_widgets/custom_app_bar.dart';

class AboutUDBScreen extends StatelessWidget {
  const AboutUDBScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "Tentang Kami"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  Helper.readAssetImages(fileName: 'udb-with-text.png'),
                  width: 200,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'VISI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Visi Universitas Duta Bangsa Surakarta adalah “Menjadi Universitas Yang Unggul di Bidang Bisnis dan Kewirausahaan di tingkat Global pada Tahun 2038',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.8),
              ),
              const SizedBox(height: 20),
              Text(
                'MISI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '1. Menyelenggarakan pendidikan berbasis kewirausahaan dan bisnis dalam rangka menyiapkan SDM  yang Mandiri, inOvatif, Visioner, beriman dan beorientasi Global\n2. Melakukan penelitian inovatif dan kreatif yang dapat meningkatkan keunggulan dan daya saing bangsa\n3. Meimplementasikan hasil teknologi dan penelitian dalam rangka meningkatkan derajat kesejahteraan masyarakat\n4. Menjalin kerjasama dalam dan luar negeri yang bermanfaat bagi kemajuan Universitas dan pengembangan keilmuan  dan teknonologi secara universal',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.8),
              ),
              const SizedBox(height: 20),
              Text(
                'TUJUAN',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "1. Menghasilkan lulusan yang memiliki moral, etika, kepribadian dan akhlakul karimah serta menjadi suri tauladan yang baik bagi masyarakat,\n2. Menghasilkan lulusan  di bidang kewirausahaan dan bisnis yang berkualitas global dalam rangka meningkatkan daya saing bangsa,\n3. Menghasilkan penelitian yang inovatif dan bermanfaat bagi kemajuan Ilmu Pengetahuan dan Teknologi,\n4. Menghasilkan karya pengabdian kepada masyarakat  dalam rangka meningkatkan kesejahteraan bangsa,\n5. Terselenggaranya kerjasama dalam dan luar negeri yang bermanfaat bagi kemajuan universitas dan pengembangan keilmuan secara universal,",
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(height: 1.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
