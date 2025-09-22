import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/config/app_config.dart';
import '../core/theme/app_theme.dart';
import 'routes/app_router.dart';

/// Root widget of the Market-Mate application
/// 
/// Configures the MaterialApp with theming, routing, and localization.
/// Uses Riverpod for state management and dependency injection.
class MarketMateApp extends ConsumerWidget {
  const MarketMateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      // App identification
      title: AppConfig.appName,
      
      // Remove debug banner in production
      debugShowCheckedModeBanner: AppConfig.isDevelopment,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      
      // Routing configuration
      routerConfig: router,
      
      // Localization (to be implemented)
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [
        Locale('ko', 'KR'),
        Locale('en', 'US'),
      ],
      
      // Global builder for additional configurations
      builder: (context, child) {
        return MediaQuery(
          // Constrain text scaling for consistent UI
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: MediaQuery.of(context)
                .textScaleFactor
                .clamp(0.8, 1.4),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}