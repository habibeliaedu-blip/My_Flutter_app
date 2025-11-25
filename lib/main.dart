import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.indigo);

    return MaterialApp(
      title: 'Message du jour',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            ),
      ),
      home: HomePage(colorScheme: colorScheme),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    required this.colorScheme,
    super.key,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primaryContainer.withOpacity(0.9),
              colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.waving_hand,
                  size: 64,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 20),
                Text(
                  'Bonjour, je vais bien',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Ravi de vous le dire !',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
