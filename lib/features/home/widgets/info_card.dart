import 'package:flutter/material.dart';
import 'package:portfolio_mobile/core/themes/font_theme.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: colorScheme.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.12),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.08),
              blurRadius: 20.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
              child: Icon(icon, size: 20.0, color: colorScheme.primary),
            ),
            const SizedBox(height: 12.0),
            Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: FontTheme.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              content,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: FontTheme.titleMedium.copyWith(
                color: colorScheme.onSurface,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
