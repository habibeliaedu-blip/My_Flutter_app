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
      title: 'Espace principal',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            ),
      ),
      home: MainShell(colorScheme: colorScheme),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({
    required this.colorScheme,
    super.key,
  });

  final ColorScheme colorScheme;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  static const _pages = [
    _PageConfig(
      title: 'Messages',
      icon: Icons.chat_bubble_outline,
    ),
    _PageConfig(
      title: 'Comptes prestataires',
      icon: Icons.people_outline,
    ),
  ));
  ];

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.colorScheme.primaryContainer.withOpacity(0.9),
              widget.colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 520),
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            decoration: BoxDecoration(
              color: widget.colorScheme.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: widget.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: widget.colorScheme.shadow.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: _buildPageContent(page, context),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: _pages
            .map(
              (page) => NavigationDestination(
                icon: Icon(page.icon),
                label: page.title,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPageContent(_PageConfig page, BuildContext context) {
    switch (page.title) {
      case 'Messages':
        return const MessagesPage();
      case 'Comptes prestataires':
        return const PrestataireAccountsPage();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _PageConfig {
  const _PageConfig({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.mark_chat_read,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 20),
        Text(
          'Messages',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'Consultez vos conversations et restez informé.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class PrestataireAccountsPage extends StatelessWidget {
  const PrestataireAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.manage_accounts,
          size: 64,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 20),
        Text(
          'Comptes prestataires',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Gérez vos profils et paramètres de prestataire.',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
