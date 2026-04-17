import 'package:flutter/material.dart';
import 'fitness_card.dart';

class StatMiniCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const StatMiniCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FitnessCard(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      borderRadius: 16,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}
