import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/navigation/navigation_cubit.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: MaterialApp(
        title: 'Flutter Liquid Glass',
        theme: AppTheme.lightTheme,
        home: const MainShell(),
      ),
    );
  }
}
