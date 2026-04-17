import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/core/theme/app_theme.dart';
import 'package:flutter_liquid_glass/presentation/widgets/circular_progress_ring.dart';
import 'package:flutter_liquid_glass/presentation/widgets/count_up_text.dart';
import 'package:flutter_liquid_glass/presentation/widgets/fitness_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/gradient_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/screen_entry_animation.dart';
import 'package:flutter_liquid_glass/presentation/widgets/section_header.dart';
import 'package:flutter_liquid_glass/presentation/widgets/stat_mini_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _ringController;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    
    // Start animation immediately
    _ringController.forward();
  }

  @override
  void dispose() {
    _ringController.dispose();
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
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: bottomPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildProgressSection(context),
                  const SizedBox(height: 24),
                  _buildQuickStatsSection(),
                  const SizedBox(height: 32),
                  _buildTodayWorkout(context),
                  const SizedBox(height: 32),
                  _buildRecentActivity(context),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning 👋',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Alex Johnson',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppTheme.surface,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_outlined, color: AppTheme.textPrimary),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'AJ',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '🔥 12 Day Streak',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Week 3 of 8',
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context) {
    return FitnessCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today\'s Goal',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  CountUpText(
                    begin: 0,
                    end: 2450,
                    duration: const Duration(milliseconds: 1000),
                    textBuilder: (val) => val.toInt().toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    ' / 3,000 cal',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 160,
            child: AnimatedBuilder(
              animation: _ringController,
              builder: (context, child) {
                final curve = CurvedAnimation(parent: _ringController, curve: Curves.easeOutCubic);
                return CustomPaint(
                  size: const Size.square(160),
                  painter: CircularProgressRing(
                    movePercent: 0.82 * curve.value,
                    exercisePercent: 0.65 * curve.value,
                    standPercent: 0.90 * curve.value,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRingLegendItem(Icons.local_fire_department, 'Move', AppTheme.primary),
              _buildRingLegendItem(Icons.fitness_center, 'Exercise', AppTheme.accent),
              _buildRingLegendItem(Icons.accessibility_new, 'Stand', AppTheme.success),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRingLegendItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  Widget _buildQuickStatsSection() {
    return Row(
      children: [
        Expanded(
          child: ScreenEntryAnimation(
            delay: const Duration(milliseconds: 80),
            child: StatMiniCard(
              title: 'Steps',
              value: '8,432',
              unit: 'steps',
              icon: Icons.directions_walk,
              iconColor: AppTheme.primary,
              onTap: () {},
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ScreenEntryAnimation(
            delay: const Duration(milliseconds: 160),
            child: StatMiniCard(
              title: 'Distance',
              value: '5.2',
              unit: 'km',
              icon: Icons.location_on,
              iconColor: AppTheme.accent,
              onTap: () {},
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ScreenEntryAnimation(
            delay: const Duration(milliseconds: 240),
            child: StatMiniCard(
              title: 'Active',
              value: '47',
              unit: 'min',
              icon: Icons.timer,
              iconColor: AppTheme.secondary,
              onTap: () {},
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ScreenEntryAnimation(
            delay: const Duration(milliseconds: 320),
            child: StatMiniCard(
              title: 'Water',
              value: '6/8',
              unit: 'glasses',
              icon: Icons.water_drop,
              iconColor: Colors.blue,
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayWorkout(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Today\'s Workout',
          onSeeAll: () {},
          actionText: 'View All',
        ),
        const SizedBox(height: 16),
        ScreenEntryAnimation(
          delay: const Duration(milliseconds: 100),
          child: GradientCard(
            gradient: AppTheme.primaryGradient,
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upper Body Power',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildTag('Strength'),
                    const SizedBox(width: 8),
                    _buildTag('45 min'),
                    const SizedBox(width: 8),
                    _buildTag('Intermediate'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '12 exercises',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Start Workout',
                            style: TextStyle(
                              color: AppTheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, color: AppTheme.secondary, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      children: [
        SectionHeader(
          title: 'Recent Activity',
          onSeeAll: () {},
        ),
        const SizedBox(height: 16),
        _buildActivityItem('Morning Run', 'Yesterday · 32 min', '320', AppTheme.accent),
        const SizedBox(height: 12),
        _buildActivityItem('Push Day', '2 days ago · 48 min', '410', AppTheme.primary),
        const SizedBox(height: 12),
        _buildActivityItem('Yoga Flow', '3 days ago · 35 min', '180', Colors.purple),
      ],
    );
  }

  Widget _buildActivityItem(String title, String subtitle, String calories, Color dotColor) {
    return FitnessCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$calories cal',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
