import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/base_colors.dart';
import 'package:portfolio_mobile/core/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _category = "full-time"; // default
  String _thumbnail = "";
  DateTime? _endedAt;

  final Map<String, String> _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickEndedAt() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endedAt ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _endedAt = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Experience Form',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: BaseColors.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Judul ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: "Judul Pengalaman",
                    labelText: "Judul Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Judul pengalaman tidak boleh kosong!";
                    }
                    if (value.trim().length > 255) {
                      return "Judul pengalaman maksimal 255 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Pengalaman",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories.entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Thumbnail ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Thumbnail (opsional)",
                    labelText: "Tautan Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return null; // opsional, sesuai blank=True di model
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null ||
                        !(uri.isScheme('http') || uri.isScheme('https'))) {
                      return "Tautan thumbnail harus berupa URL yang valid!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Selesai ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: _pickEndedAt,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText:
                          "Tanggal Selesai (kosongkan jika masih berlangsung)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      suffixIcon: _endedAt == null
                          ? const Icon(Icons.calendar_today)
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  _endedAt = null;
                                });
                              },
                            ),
                    ),
                    child: Text(
                      _endedAt == null
                          ? "Masih berlangsung"
                          : _formatDate(_endedAt!),
                    ),
                  ),
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        BaseColors.primary,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Judul: $_title'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: ${_categories[_category]}'),
                                    Text(
                                      'Thumbnail: ${_thumbnail.trim().isEmpty ? "-" : _thumbnail}',
                                    ),
                                    Text(
                                      'Status: ${_endedAt == null ? "Masih berlangsung" : "Selesai pada ${_formatDate(_endedAt!)}"}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _category = 'full-time';
                                      _endedAt = null;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
