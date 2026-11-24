import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/base_colors.dart';
import 'package:portfolio_mobile/features/projects/models/project.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({required this.project, super.key});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final hasImage = project.projectImageUrl.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: BaseColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  project.projectImageUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 16),
            ],
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Tech Stack: ${project.techStack}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(project.description),
            if (project.projectUrl.trim().isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Project URL: ${project.projectUrl}',
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
