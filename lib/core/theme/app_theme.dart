import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette (Light Mode)
  static const Color primary = Color(0xFFFF6B35); // Energetic orange
  static const Color secondary = Color(0xFF1A1A2E); // Deep navy
  static const Color accent = Color(0xFF4ECDC4); // Teal
  static const Color background = Color(0xFFF8F9FA); // Off-white
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surface2 = Color(0xFFF0F2F5); // Light gray cards
  static const Color textPrimary = Color(0xFF1A1A2E); // Deep navy
  static const Color textSecondary = Color(0xFF6B7280); // Gray
  static const Color success = Color(0xFF22C55E); // Green
  static const Color warning = Color(0xFFF59E0B); // Yellow/Orange
  
  // Custom Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF8B5E), primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Custom Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.figtreeTextTheme();
    
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: secondary,
        surface: surface,
        surfaceContainerHighest: surface2,
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
      ),
      scaffoldBackgroundColor: background,
      textTheme: baseTextTheme.copyWith(
        displayLarge: baseTextTheme.displayLarge?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        displayMedium: baseTextTheme.displayMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        displaySmall: baseTextTheme.displaySmall?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        headlineMedium: baseTextTheme.headlineMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: textPrimary, fontWeight: FontWeight.bold),
        titleLarge: baseTextTheme.titleLarge?.copyWith(color: textPrimary, fontWeight: FontWeight.w600),
        titleMedium: baseTextTheme.titleMedium?.copyWith(color: textPrimary, fontWeight: FontWeight.w600),
        titleSmall: baseTextTheme.titleSmall?.copyWith(color: textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: textPrimary),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: textPrimary),
        bodySmall: baseTextTheme.bodySmall?.copyWith(color: textSecondary),
        labelLarge: baseTextTheme.labelLarge?.copyWith(color: textPrimary, fontWeight: FontWeight.w600),
        labelMedium: baseTextTheme.labelMedium?.copyWith(color: textSecondary),
        labelSmall: baseTextTheme.labelSmall?.copyWith(color: textSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface2,
        disabledColor: surface2.withOpacity(0.5),
        selectedColor: primary,
        secondarySelectedColor: primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        labelStyle: const TextStyle(color: textSecondary, fontWeight: FontWeight.w500),
        secondaryLabelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 4,
      ),
      dividerTheme: const DividerThemeData(
        color: surface2,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
