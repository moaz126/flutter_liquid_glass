import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final String actionText;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.actionText = 'See All',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primary,
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
            child: Text(actionText),
          ),
      ],
    );
  }
}
