import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/base_colors.dart';
import 'package:portfolio_mobile/core/themes/font_theme.dart';
import 'package:portfolio_mobile/features/home/widgets/info_card.dart';
import 'package:portfolio_mobile/core/widgets/left_drawer.dart';
import 'package:portfolio_mobile/features/experiences/pages/experience_form.dart';
import 'package:portfolio_mobile/features/projects/pages/project_form.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506584861";
  final String nama = "Mohammad Zidane Kurnianto";
  final String kelas = "PBP F";

  final List<ItemHomepage> items = [
    ItemHomepage('Lihat Proyek', Icons.folder_rounded, BaseColors.primary500),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle_rounded,
      BaseColors.secondary500,
    ),
    ItemHomepage('Tambah Pengalaman', Icons.work_rounded, BaseColors.warning),
    ItemHomepage('Logout', Icons.logout_rounded, BaseColors.error),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary,
                          width: 3.0,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 48.0,
                        backgroundImage: AssetImage(
                          'assets/images/self-portrait.jpg',
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      nama,
                      textAlign: TextAlign.center,
                      style: FontTheme.headlineMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      kelas,
                      textAlign: TextAlign.center,
                      style: FontTheme.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              IntrinsicHeight(
                child: Row(
                  children: [
                    InfoCard(
                      title: 'NPM',
                      content: npm,
                      icon: Icons.badge_rounded,
                    ),
                    InfoCard(
                      title: 'Name',
                      content: nama,
                      icon: Icons.person_rounded,
                    ),
                    InfoCard(
                      title: 'Class',
                      content: kelas,
                      icon: Icons.school_rounded,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28.0),

              Center(
                child: Column(
                  children: [
                    Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      textAlign: TextAlign.center,
                      style: FontTheme.headlineMedium.copyWith(
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Pilih salah satu menu di bawah ini',
                      textAlign: TextAlign.center,
                      style: FontTheme.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              GridView.count(
                padding: EdgeInsets.zero,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  const ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      elevation: 6.0,
      shadowColor: item.color.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(18.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.0),
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );
          // Navigate ke halaman yang sesuai
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProjectFormPage()),
            );
          } else if (item.name == "Tambah Pengalaman") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExperienceFormPage()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: Colors.white, size: 28.0),
              const SizedBox(height: 8.0),
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: FontTheme.labelLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
