import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/core/theme/app_theme.dart';
import 'package:flutter_liquid_glass/presentation/widgets/fitness_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/screen_entry_animation.dart';
import 'package:flutter_liquid_glass/presentation/widgets/section_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom + 100;

    return ScreenEntryAnimation(
      child: Scaffold(
        backgroundColor: AppTheme.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildProfileHeader(context),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: bottomPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildGoalProgress(),
                  const SizedBox(height: 32),
                  _buildSettingsGroup(
                    'Account',
                    [
                      _SettingsItem(icon: Icons.person_outline, color: Colors.blue, title: 'Edit Profile'),
                      _SettingsItem(
                        icon: Icons.notifications_none,
                        color: AppTheme.primary,
                        title: 'Notifications',
                        badge: '3 new',
                      ),
                      _SettingsItem(icon: Icons.lock_outline, color: AppTheme.secondary, title: 'Privacy & Security'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsGroup(
                    'Preferences',
                    [
                      _SettingsItem(icon: Icons.straighten, color: AppTheme.accent, title: 'Units', value: 'Metric'),
                      _SettingsItem(
                        icon: Icons.alarm,
                        color: Colors.purple,
                        title: 'Workout Reminders',
                        isToggle: true,
                        toggleValue: true,
                      ),
                      _SettingsItem(icon: Icons.wb_sunny_outlined, color: Colors.orange, title: 'Theme', value: 'Light'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildSettingsGroup(
                    'More',
                    [
                      _SettingsItem(icon: Icons.help_outline, color: Colors.teal, title: 'Help & Support'),
                      _SettingsItem(icon: Icons.star_border, color: Colors.amber, title: 'Rate the App'),
                      _SettingsItem(icon: Icons.exit_to_app, color: Colors.red, title: 'Log Out', isDestructive: true),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildAppVersion(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 24,
        bottom: 24,
      ),
      color: AppTheme.surface,
      child: Column(
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
              boxShadow: AppTheme.softShadow,
            ),
            alignment: Alignment.center,
            child: const Text(
              'AJ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Alex Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Fitness enthusiast · 2 years streak',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildHeaderStat('127', 'workouts'),
              Container(width: 1, height: 30, color: AppTheme.surface2),
              _buildHeaderStat('48', 'following'),
              Container(width: 1, height: 30, color: AppTheme.surface2),
              _buildHeaderStat('312', 'followers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalProgress() {
    return Column(
      children: [
        const SectionHeader(title: 'Monthly Goals'),
        const SizedBox(height: 16),
        FitnessCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildProgressBar('Workout 20 times', '14/20', 0.70, AppTheme.primary),
              const SizedBox(height: 20),
              _buildProgressBar('Burn 10,000 cal', '6,840/10,000', 0.68, AppTheme.accent),
              const SizedBox(height: 20),
              _buildProgressBar('Run 50 km', '31.2/50 km', 0.62, AppTheme.secondary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(String title, String value, double percent, Color color) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent * _progressController.value,
                backgroundColor: AppTheme.surface2,
                color: color,
                minHeight: 8,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSettingsGroup(String title, List<_SettingsItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        FitnessCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return Column(
                children: [
                  ListTile(
                    onTap: () {},
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: item.color.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(item.icon, color: item.color, size: 20),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: item.isDestructive ? Colors.red : AppTheme.textPrimary,
                      ),
                    ),
                    trailing: _buildTrailing(item),
                  ),
                  if (!isLast)
                    const Divider(
                      height: 1,
                      thickness: 0.5,
                      indent: 64,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTrailing(_SettingsItem item) {
    if (item.isToggle) {
      return Switch(
        value: item.toggleValue,
        onChanged: (val) {},
        activeColor: AppTheme.primary,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item.badge!,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        if (item.value != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              item.value!,
              style: const TextStyle(color: AppTheme.textSecondary),
            ),
          ),
        if (!item.isDestructive)
          const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }

  Widget _buildAppVersion() {
    return Column(
      children: [
        const Text(
          'FitTrack v1.0.0',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Made with ❤️ for fitness lovers',
          style: TextStyle(
            color: AppTheme.textSecondary.withOpacity(0.7),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final Color color;
  final String title;
  final String? badge;
  final String? value;
  final bool isToggle;
  final bool toggleValue;
  final bool isDestructive;

  _SettingsItem({
    required this.icon,
    required this.color,
    required this.title,
    this.badge,
    this.value,
    this.isToggle = false,
    this.toggleValue = false,
    this.isDestructive = false,
  });
}
