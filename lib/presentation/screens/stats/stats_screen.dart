import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/core/theme/app_theme.dart';
import 'package:flutter_liquid_glass/presentation/widgets/bar_chart_painter.dart';
import 'package:flutter_liquid_glass/presentation/widgets/screen_entry_animation.dart';
import 'package:flutter_liquid_glass/presentation/widgets/fitness_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/gradient_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/section_header.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> with TickerProviderStateMixin {
  late final AnimationController _chartController;
  late final Animation<double> _chartCurve;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _chartCurve = CurvedAnimation(parent: _chartController, curve: Curves.easeOutCubic);
    _chartController.forward();
  }

  @override
  void dispose() {
    _chartController.dispose();
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
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 20,
                  right: 20,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Progress',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildPeriodSelector(),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: bottomPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _HeroStatsSection(),
                  const SizedBox(height: 32),
                  _buildActivityChart(),
                  const SizedBox(height: 32),
                  const _PersonalRecordsSection(),
                  const SizedBox(height: 32),
                  const _BodyMeasurementsSection(),
                  const SizedBox(height: 32),
                  const _RecentAchievementsSection(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildTab('Week', 0),
          _buildTab('Month', 1),
          _buildTab('Year', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_selectedTabIndex != index) {
            setState(() {
              _selectedTabIndex = index;
              _chartController.forward(from: 0.0);
            });
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textSecondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    return ScreenEntryAnimation(
      delay: const Duration(milliseconds: 200),
      child: FitnessCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '12,450 cal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 160,
              child: Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('1000', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                      Text('500', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                      Text('0', style: TextStyle(color: AppTheme.textSecondary, fontSize: 10)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimatedBuilder(
                            animation: _chartController,
                            builder: (context, child) {
                              return CustomPaint(
                                size: Size.infinite,
                                painter: BarChartPainter(
                                  percentages: const [0.60, 0.80, 0.45, 0.90, 0.70, 0.30, 0.85],
                                  animationValue: _chartCurve.value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Mon', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Tue', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Wed', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Thu', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Fri', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Sat', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                            Text('Sun', style: TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStatsSection extends StatelessWidget {
  const _HeroStatsSection();

  @override
  Widget build(BuildContext context) {
    return const ScreenEntryAnimation(
      delay: Duration(milliseconds: 100),
      child: GradientCard(
        gradient: AppTheme.primaryGradient,
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This Week',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              '4 Workouts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Divider(color: Colors.white24, height: 1),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HeroStatItem(icon: Icons.timer_outlined, label: 'Total Time', value: '3h 12m'),
                _HeroStatItem(icon: Icons.local_fire_department_outlined, label: 'Calories', value: '1,680'),
                _HeroStatItem(icon: Icons.favorite_border, label: 'Avg HR', value: '142 bpm'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroStatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _HeroStatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _PersonalRecordsSection extends StatelessWidget {
  const _PersonalRecordsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Personal Records 🏆',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          padding: EdgeInsets.zero,
          children: const [
            _PRCard(title: 'Longest Run', value: '12.4 km', date: 'set 2 weeks ago'),
            _PRCard(title: 'Most Calories', value: '680 cal', date: 'set last week'),
            _PRCard(title: 'Workout Streak', value: '12 days', date: 'current'),
            _PRCard(title: 'Max Push-ups', value: '48 reps', date: 'set 3 days ago'),
          ],
        ),
      ],
    );
  }
}

class _PRCard extends StatelessWidget {
  final String title;
  final String value;
  final String date;

  const _PRCard({
    required this.title,
    required this.value,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.primary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            date,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _BodyMeasurementsSection extends StatelessWidget {
  const _BodyMeasurementsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Body Stats'),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            children: const [
              _StatCard(title: 'Weight', value: '74.2 kg', trend: '↓ 0.8', trendColor: AppTheme.success),
              SizedBox(width: 16),
              _StatCard(title: 'Body Fat', value: '16.4%', trend: '↓ 0.3%', trendColor: AppTheme.success),
              SizedBox(width: 16),
              _StatCard(title: 'Muscle', value: '38.1 kg', trend: '↑ 0.5 kg', trendColor: AppTheme.primary),
              SizedBox(width: 16),
              _StatCard(title: 'BMI', value: '22.8', trend: '→ stable', trendColor: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String trend;
  final Color trendColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.trend,
    required this.trendColor,
  });

  @override
  Widget build(BuildContext context) {
    return FitnessCard(
      width: 140,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                trend,
                style: TextStyle(
                  color: trendColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecentAchievementsSection extends StatelessWidget {
  const _RecentAchievementsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'Achievements', actionText: '12 earned'),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              _Badge(emoji: '🔥', name: 'First Streak', gradient: LinearGradient(colors: [Colors.orange, Colors.red])),
              SizedBox(width: 16),
              _Badge(emoji: '⚡', name: 'Speed Demon', gradient: LinearGradient(colors: [Colors.yellow, Colors.orange])),
              SizedBox(width: 16),
              _Badge(emoji: '💪', name: 'Iron Will', gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
              SizedBox(width: 16),
              _Badge(emoji: '🎯', name: 'Goal Crusher', gradient: LinearGradient(colors: [AppTheme.accent, Colors.blue])),
            ],
          ),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String emoji;
  final String name;
  final Gradient gradient;

  const _Badge({
    required this.emoji,
    required this.name,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: gradient,
            boxShadow: AppTheme.softShadow,
          ),
          alignment: Alignment.center,
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
