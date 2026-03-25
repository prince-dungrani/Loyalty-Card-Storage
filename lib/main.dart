import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loyalty_card_storage_app/core/theme/app_theme.dart';
import 'package:loyalty_card_storage_app/features/auth/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Note: Hive initialization is managed within the services
  // but we can call a warmup here if needed.
  
  runApp(
    const ProviderScope(
      child: LoyaltyCardApp(),
    ),
  );
}

class LoyaltyCardApp extends StatelessWidget {
  const LoyaltyCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Everyday Rewards',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
