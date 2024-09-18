import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yu_gi_oh_app/config/theme/app_theme.dart';
import 'package:yu_gi_oh_app/presentation/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'YuGiOh Card Catalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomePage(),
    );
  }
}
