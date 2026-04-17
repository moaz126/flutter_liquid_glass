import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/core/theme/app_theme.dart';
import 'package:flutter_liquid_glass/presentation/widgets/fitness_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/gradient_card.dart';
import 'package:flutter_liquid_glass/presentation/widgets/screen_entry_animation.dart';
import 'package:flutter_liquid_glass/presentation/widgets/section_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _categories = [
    'All',
    'Strength',
    'Cardio',
    'Yoga',
    'HIIT',
    'Pilates',
    'Running'
  ];
  int _selectedCategoryIndex = 0;
  bool _isSearchFocused = false;

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
                      'Explore',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Find your next challenge',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildSearchBar(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: _buildCategoryChips(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: _buildTrendingSection(),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: bottomPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SectionHeader(title: 'All Workouts'),
                    const SizedBox(height: 16),
                    _buildWorkoutGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppTheme.surface2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isSearchFocused ? AppTheme.primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focused) {
            setState(() {
              _isSearchFocused = focused;
            });
          },
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search workouts, exercises...',
              hintStyle: const TextStyle(color: AppTheme.textSecondary),
              prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
              suffixIcon: const Icon(Icons.mic, color: AppTheme.textSecondary),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : AppTheme.surface2,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      children: [
        const SectionHeader(title: 'Trending This Week'),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildTrendingCard(
                '30-Day Ab Challenge',
                ['30 days', 'Beginner', '⭐ 4.8'],
                const LinearGradient(
                  colors: [AppTheme.accent, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(width: 16),
              _buildTrendingCard(
                'HIIT Inferno',
                ['25 min/day', 'Advanced', '⭐ 4.9'],
                const LinearGradient(
                  colors: [AppTheme.primary, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(width: 16),
              _buildTrendingCard(
                'Morning Yoga',
                ['20 min/day', 'All levels', '⭐ 4.7'],
                const LinearGradient(
                  colors: [Colors.purple, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingCard(String title, List<String> tags, Gradient gradient) {
    return GradientCard(
      width: 260,
      gradient: gradient,
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: bold, // using local const for short form, wait just use FontWeight.bold
            ),
          ),
          const Spacer(),
          Row(
            children: tags
                .map((tag) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        '· $tag',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  static const FontWeight bold = FontWeight.bold;

  Widget _buildWorkoutGrid() {
    final workouts = [
      {'title': 'Push & Pull', 'icon': '💪', 'color': AppTheme.primary, 'duration': '45 min', 'cal': '380 cal'},
      {'title': 'Morning HIIT', 'icon': '⚡', 'color': Colors.red, 'duration': '20 min', 'cal': '290 cal'},
      {'title': 'Full Body Stretch', 'icon': '🧘', 'color': Colors.purple, 'duration': '30 min', 'cal': '120 cal'},
      {'title': 'Leg Day', 'icon': '🦵', 'color': AppTheme.accent, 'duration': '50 min', 'cal': '440 cal'},
      {'title': 'Core Blast', 'icon': '🔥', 'color': AppTheme.primary, 'duration': '25 min', 'cal': '210 cal'},
      {'title': 'Cycling', 'icon': '🚴', 'color': Colors.blue, 'duration': '40 min', 'cal': '350 cal'},
      {'title': 'Swimming', 'icon': '🏊', 'color': AppTheme.accent, 'duration': '35 min', 'cal': '300 cal'},
      {'title': 'Back & Biceps', 'icon': '💪', 'color': AppTheme.secondary, 'duration': '42 min', 'cal': '360 cal'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return ScreenEntryAnimation(
          delay: Duration(milliseconds: index * 60),
          child: FitnessCard(
            onTap: () {},
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: (workout['color'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    workout['icon'] as String,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  workout['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.surface2,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        workout['duration'] as String,
                        style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  workout['cal'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
