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
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
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
                  _buildHeroStats(),
                  const SizedBox(height: 32),
                  _buildActivityChart(),
                  const SizedBox(height: 32),
                  _buildPersonalRecords(),
                  const SizedBox(height: 32),
                  _buildBodyMeasurements(),
                  const SizedBox(height: 32),
                  _buildRecentAchievements(),
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
          setState(() {
            _selectedTabIndex = index;
            // Retrigger chart animation
            _chartController.forward(from: 0.0);
          });
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

  Widget _buildHeroStats() {
    return ScreenEntryAnimation(
      delay: const Duration(milliseconds: 100),
      child: GradientCard(
        gradient: AppTheme.primaryGradient,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This Week',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              '4 Workouts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24, height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeroStatItem(Icons.timer_outlined, 'Total Time', '3h 12m'),
                _buildHeroStatItem(Icons.local_fire_department_outlined, 'Calories', '1,680'),
                _buildHeroStatItem(Icons.favorite_border, 'Avg HR', '142 bpm'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroStatItem(IconData icon, String label, String value) {
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

  Widget _buildActivityChart() {
    return ScreenEntryAnimation(
      delay: const Duration(milliseconds: 200),
      child: FitnessCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
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
                              final curve = CurvedAnimation(parent: _chartController, curve: Curves.easeOutCubic);
                              return CustomPaint(
                                size: Size.infinite,
                                painter: BarChartPainter(
                                  percentages: const [0.60, 0.80, 0.45, 0.90, 0.70, 0.30, 0.85],
                                  animationValue: curve.value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
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

  Widget _buildPersonalRecords() {
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
          children: [
            _buildPRCard('Longest Run', '12.4 km', 'set 2 weeks ago'),
            _buildPRCard('Most Calories', '680 cal', 'set last week'),
            _buildPRCard('Workout Streak', '12 days', 'current'),
            _buildPRCard('Max Push-ups', '48 reps', 'set 3 days ago'),
          ],
        ),
      ],
    );
  }

  Widget _buildPRCard(String title, String value, String date) {
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

  Widget _buildBodyMeasurements() {
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
            children: [
              _buildStatCard('Weight', '74.2 kg', '↓ 0.8', AppTheme.success),
              const SizedBox(width: 16),
              _buildStatCard('Body Fat', '16.4%', '↓ 0.3%', AppTheme.success),
              const SizedBox(width: 16),
              _buildStatCard('Muscle', '38.1 kg', '↑ 0.5 kg', AppTheme.primary),
              const SizedBox(width: 16),
              _buildStatCard('BMI', '22.8', '→ stable', Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String trend, Color trendColor) {
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

  Widget _buildRecentAchievements() {
    return Column(
      children: [
        const SectionHeader(title: 'Achievements', actionText: '12 earned'),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildBadge('🔥', 'First Streak', const LinearGradient(colors: [Colors.orange, Colors.red])),
              const SizedBox(width: 16),
              _buildBadge('⚡', 'Speed Demon', const LinearGradient(colors: [Colors.yellow, Colors.orange])),
              const SizedBox(width: 16),
              _buildBadge('💪', 'Iron Will', const LinearGradient(colors: [Colors.blue, Colors.purple])),
              const SizedBox(width: 16),
              _buildBadge('🎯', 'Goal Crusher', const LinearGradient(colors: [AppTheme.accent, Colors.blue])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String emoji, String name, Gradient gradient) {
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
