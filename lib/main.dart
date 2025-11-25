import 'package:flutter/material.dart';
     2
     3  void main() {
     4    runApp(const MyApp());
     5  }
     6
     7  class MyApp extends StatelessWidget {
     8    const MyApp({super.key});
     9
    10    @override
    11    Widget build(BuildContext context) {
    12      return MaterialApp(
    13        title: 'Hello World App',
    14        debugShowCheckedModeBanner: false,
    15        theme: ThemeData(
    16          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    17          useMaterial3: true,
    18        ),
    19        home: const HomePage(),
    20      );
    21    }
    22  }
    23
    24  class HomePage extends StatelessWidget {
    25    const HomePage({super.key});
    26
    27    @override
    28    Widget build(BuildContext context) {
    29      final colorScheme = Theme.of(context).colorScheme;
    30
    31      return Scaffold(
    32        appBar: AppBar(
    33          title: const Text('Accueil'),
    34          centerTitle: true,
    35          backgroundColor: colorScheme.surface,
    36          foregroundColor: colorScheme.onSurface,
    37          elevation: 0,
    38        ),
    39        body: Container(
    40          decoration: BoxDecoration(
    41            gradient: LinearGradient(
    42              begin: Alignment.topCenter,
    43              end: Alignment.bottomCenter,
    44              colors: [
    45                colorScheme.primaryContainer,
    46                colorScheme.surface,
    47              ],
    48            ),
    49          ),
    50          child: Center(
    51            child: Card(
    52              elevation: 6,
    53              shape: RoundedRectangleBorder(
    54                borderRadius: BorderRadius.circular(16),
    55              ),
    56              color: colorScheme.surface,
    57              child: Padding(
    58                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
    59                child: Column(
    60                  mainAxisSize: MainAxisSize.min,
    61                  children: [
    62                    Icon(
    63                      Icons.waving_hand,
    64                      size: 48,
    65                      color: colorScheme.primary,
    66                    ),
    67                    const SizedBox(height: 12),
    68                    Text(
    69                      'Hello World',
    70                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
    71                            fontWeight: FontWeight.bold,
    72                            color: colorScheme.onSurface,
    73                          ),
    74                    ),
    75                    const SizedBox(height: 8),
    76                    Text(
    77                      'Bienvenue dans votre application Flutter.',
    78                      textAlign: TextAlign.center,
    79                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    80                            color: colorScheme.onSurfaceVariant,
    81                          ),
    82                    ),
    83                  ],
    84                ),
    85              ),
    86            ),
    87          ),
    88        ),
    89      );
    90    }
    91  }
