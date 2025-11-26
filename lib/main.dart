import 'package:flutter/material.dart';

const backgroundImageAsset = 'assets/images/back.png';
const logoImageAsset = 'assets/images/logo.png';
const _maxContentWidth = 1280.0;

class UserProfile {
  UserProfile({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.profession,
  });

  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final int age;
  final String profession;

  UserProfile copyWith({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    int? age,
    String? profession,
  }) {
    return UserProfile(
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      profession: profession ?? this.profession,
    );
  }
}

class AppState extends ChangeNotifier {
  UserProfile? _profile;

  UserProfile? get profile => _profile;
  bool get isLoggedIn => _profile != null;

  void signIn(UserProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  void updateProfile(UserProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  void signOut() {
    _profile = null;
    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({super.key, required super.notifier, required super.child});

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppStateScope>();
    assert(scope != null, 'AppStateScope not found in context');
    return scope!.notifier!;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppState _appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      notifier: _appState,
      child: MaterialApp(
        title: 'JOKKO DIMBALI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A4F58)),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.transparent,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
        routes: {
          HomePage.routeName: (_) => const HomePage(),
          ReservationPage.routeName: (_) => const ReservationPage(),
          RdvPage.routeName: (_) => const RdvPage(),
          MessagesPage.routeName: (_) => const MessagesPage(),
          SettingsPage.routeName: (_) => const SettingsPage(),
        },
        initialRoute: HomePage.routeName,
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.child,
    this.pageTitle,
    super.key,
  });

  final Widget child;
  final String? pageTitle;

  @override
  Widget build(BuildContext context) {
    final routeName = ModalRoute.of(context)?.settings.name ?? '';

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              backgroundImageAsset,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: _maxContentWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _TopBar(activeRoute: routeName),
                      if (pageTitle != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          pageTitle!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(child: child),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// HOME PAGE
// ------------------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _SearchPanel(),
          const SizedBox(height: 16),
          _FavoritesBar(textTheme: textTheme),
          const SizedBox(height: 16),
          const _ServiceGrid(),
          const SizedBox(height: 20),
          const _ProfessionalsRow(),
          const SizedBox(height: 20),
          const _EmergencyCard(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// PAGES (RDV, MESSAGES, SETTINGS…)
// ------------------------------------------------------------

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});
  static const routeName = '/reservation';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: 'RDV Réservation',
      child: _SectionCard(
        icon: Icons.event_available,
        title: 'RDV Réservation',
        description:
        'Planifiez vos rendez-vous en choisissant un service, une date et un lieu.',
      ),
    );
  }
}

class RdvPage extends StatelessWidget {
  const RdvPage({super.key});
  static const routeName = '/rdv';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: 'RDV',
      child: _SectionCard(
        icon: Icons.calendar_month,
        title: 'Vos rendez-vous',
        description: 'Consultez vos rendez-vous programmés.',
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  static const routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      pageTitle: 'Messages',
      child: _SectionCard(
        icon: Icons.message_outlined,
        title: 'Messages',
        description: 'Échangez avec vos interlocuteurs.',
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final appState = AppStateScope.of(context);

    return AppScaffold(
      pageTitle: 'Paramètres du compte',
      child: AnimatedBuilder(
        animation: appState,
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AccountHeader(appState: appState),
              const SizedBox(height: 16),
              if (!appState.isLoggedIn)
                _SignInForm(appState: appState)
              else
                _ProfileForm(appState: appState),
            ],
          );
        },
      ),
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader({required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: colorScheme.primary.withOpacity(0.15),
            child: const Icon(Icons.person, size: 32, color: Colors.black87),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appState.isLoggedIn
                      ? '${appState.profile!.firstName} ${appState.profile!.lastName}'
                      : 'Renseignez vos informations',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  appState.isLoggedIn
                      ? 'Connecté : ${appState.profile!.email}'
                      : 'Connectez-vous pour gérer votre compte.',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          if (appState.isLoggedIn)
            OutlinedButton.icon(
              onPressed: () => appState.signOut(),
              icon: const Icon(Icons.logout),
              label: const Text('Déconnexion'),
            ),
        ],
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({required this.appState});

  final AppState appState;

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _professionController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final age = int.tryParse(_ageController.text.trim());
    if (age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Merci de saisir un âge valide.')),
      );
      return;
    }

    final profile = UserProfile(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      age: age,
      profession: _professionController.text.trim(),
    );

    widget.appState.signIn(profile);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Connexion réussie !')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connexion / Création de compte',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _LabeledField(
                  label: 'Adresse mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez saisir une adresse mail'
                      : null,
                ),
                _LabeledField(
                  label: 'Mot de passe',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez saisir un mot de passe'
                      : null,
                ),
                _LabeledField(
                  label: 'Prénom',
                  controller: _firstNameController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre prénom'
                      : null,
                ),
                _LabeledField(
                  label: 'Nom',
                  controller: _lastNameController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre nom'
                      : null,
                ),
                _LabeledField(
                  label: 'Âge',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre âge'
                      : null,
                ),
                _LabeledField(
                  label: 'Profession',
                  controller: _professionController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre profession'
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.login),
                label: const Text('Se connecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileForm extends StatefulWidget {
  const _ProfileForm({required this.appState});

  final AppState appState;

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;
  late TextEditingController _professionController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _ageController = TextEditingController();
    _professionController = TextEditingController();
    _applyProfile(widget.appState.profile!);
  }

  @override
  void didUpdateWidget(covariant _ProfileForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.appState.profile != widget.appState.profile) {
      _applyProfile(widget.appState.profile!);
    }
  }

  void _applyProfile(UserProfile profile) {
    _emailController.text = profile.email;
    _passwordController.text = profile.password;
    _firstNameController.text = profile.firstName;
    _lastNameController.text = profile.lastName;
    _ageController.text = profile.age.toString();
    _professionController.text = profile.profession;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final age = int.tryParse(_ageController.text.trim());
    if (age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Merci de saisir un âge valide.')),
      );
      return;
    }

    final updatedProfile = widget.appState.profile!.copyWith(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      age: age,
      profession: _professionController.text.trim(),
    );

    widget.appState.updateProfile(updatedProfile);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil mis à jour.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.black87),
                const SizedBox(width: 8),
                Text(
                  'Informations du compte',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                _LabeledField(
                  label: 'Adresse mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez saisir une adresse mail'
                      : null,
                ),
                _LabeledField(
                  label: 'Mot de passe',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Veuillez saisir un mot de passe'
                      : null,
                ),
                _LabeledField(
                  label: 'Prénom',
                  controller: _firstNameController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre prénom'
                      : null,
                ),
                _LabeledField(
                  label: 'Nom',
                  controller: _lastNameController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre nom'
                      : null,
                ),
                _LabeledField(
                  label: 'Âge',
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre âge'
                      : null,
                ),
                _LabeledField(
                  label: 'Profession',
                  controller: _professionController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Indiquez votre profession'
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () => widget.appState.signOut(),
                  icon: const Icon(Icons.logout),
                  label: const Text('Se déconnecter'),
                ),
                ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.save_alt),
                  label: const Text('Enregistrer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        validator: validator,
      ),
    );
  }
}

// ------------------------------------------------------------
// TOP BAR
// ------------------------------------------------------------

class _TopBar extends StatelessWidget {
  const _TopBar({required this.activeRoute});

  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appState = AppStateScope.of(context);

    final navItems = [
      _NavItem(label: 'Accueil', icon: Icons.home_outlined, route: HomePage.routeName),
      _NavItem(
          label: 'RDV réservation',
          icon: Icons.event_available_outlined,
          route: ReservationPage.routeName),
      _NavItem(
          label: 'RDV', icon: Icons.calendar_month_outlined, route: RdvPage.routeName),
      _NavItem(
          label: 'Messages', icon: Icons.mail_outline, route: MessagesPage.routeName),
      _NavItem(
          label: 'Mon compte',
          icon: Icons.settings_outlined,
          route: SettingsPage.routeName),
    ];

    return AnimatedBuilder(
      animation: appState,
      builder: (context, _) {
        final navButtons = Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: navItems
              .map(
                (item) => _TopNavButton(
              item: item,
              isActive: activeRoute == item.route,
              colorScheme: colorScheme,
            ),
          )
              .toList(),
        );

        final branding = Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(logoImageAsset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Jokko Dimbali',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        );

        final profileName = appState.isLoggedIn
            ? '${appState.profile!.firstName} ${appState.profile!.lastName}'
            : 'Se connecter';

        final profile = InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (ModalRoute.of(context)?.settings.name == SettingsPage.routeName) return;
            Navigator.of(context).pushNamed(SettingsPage.routeName);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFD8DDE3),
                  child: Icon(Icons.person, color: Colors.black54),
                ),
                const SizedBox(width: 8),
                Text(
                  profileName,
                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 900;

            if (isNarrow) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [branding, profile],
                  ),
                  const SizedBox(height: 12),
                  navButtons,
                ],
              );
            }

            return Row(
              children: [
                branding,
                const SizedBox(width: 20),
                Expanded(child: navButtons),
                const SizedBox(width: 20),
                profile,
              ],
            );
          },
        );
      },
    );
  }
}

class _TopNavButton extends StatelessWidget {
  const _TopNavButton({
    required this.item,
    required this.isActive,
    required this.colorScheme,
  });

  final _NavItem item;
  final bool isActive;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final background = isActive ? colorScheme.primary : Colors.white;
    final foreground = isActive ? colorScheme.onPrimary : Colors.black87;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          if (ModalRoute.of(context)?.settings.name == item.route) return;
          Navigator.of(context).pushNamed(item.route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Icon(item.icon, size: 20, color: foreground),
              const SizedBox(width: 8),
              Text(
                item.label,
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;
}

// ------------------------------------------------------------
// SEARCH PANEL
// ------------------------------------------------------------

class _SearchPanel extends StatelessWidget {
  const _SearchPanel();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.82),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black38, blurRadius: 12, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rendez-vous et Réservation',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Rechercher',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF5B7DB8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: const [
                Icon(Icons.medical_services_outlined, color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text(
                  'Urgence ou consultation',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// FAVORITES
// ------------------------------------------------------------

class _FavoritesBar extends StatelessWidget {
  const _FavoritesBar({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final favorites = ['Bricolage', 'Mécanique', 'Ménage', 'Jardinage', 'Plomberie'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favoris (2)',
            style: textTheme.titleMedium?.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: favorites
                .map(
                  (fav) => Chip(
                label: Text(
                  fav,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// SERVICE GRID
// ------------------------------------------------------------

class _ServiceGrid extends StatelessWidget {
  const _ServiceGrid();

  @override
  Widget build(BuildContext context) {
    final services = [
      _Service(icon: Icons.handyman, label: 'Bricolage'),
      _Service(icon: Icons.build_circle_outlined, label: 'Mécanique'),
      _Service(icon: Icons.cleaning_services_outlined, label: 'Ménage'),
      _Service(icon: Icons.grass_outlined, label: 'Jardinage'),
      _Service(icon: Icons.plumbing, label: 'Plomberie'),
      _Service(icon: Icons.emoji_people, label: 'Avocat'),
      _Service(icon: Icons.mosque, label: 'Imam'),
      _Service(icon: Icons.miscellaneous_services_outlined, label: 'Autres'),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          var crossAxisCount = (constraints.maxWidth / 180).floor();
          if (crossAxisCount < 2) crossAxisCount = 2;
          if (crossAxisCount > 5) crossAxisCount = 5;

          final itemWidth =
              (constraints.maxWidth - (12 * (crossAxisCount - 1))) / crossAxisCount;

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: services
                .map(
                  (service) => SizedBox(
                width: itemWidth,
                child: _ServiceCard(service: service),
              ),
            )
                .toList(),
          );
        },
      ),
    );
  }
}

class _Service {
  const _Service({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final _Service service;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(service.icon, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            service.label,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// PROFESSIONALS (CARDS)
// ------------------------------------------------------------

class _ProfessionalsRow extends StatelessWidget {
  const _ProfessionalsRow();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
              child: _ProfessionalCard(
                name: 'Brahima Diallo',
                specialty: 'Menuisier',
                rating: 4.5,
                reviews: 235,
                location: 'Paris',
                phone: '+33 7 89 56 34 21',
              ),
            ),
            SizedBox(
              width: isNarrow ? constraints.maxWidth : (constraints.maxWidth - 16) / 2,
              child: _ProfessionalCard(
                name: 'Babacar Gueye',
                specialty: 'Mécanicien',
                rating: 5.0,
                reviews: 523,
                location: 'Dakar',
                phone: '+221 7 89 56 34 21',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProfessionalCard extends StatelessWidget {
  const _ProfessionalCard({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.phone,
  });

  final String name;
  final String specialty;
  final double rating;
  final int reviews;
  final String location;
  final String phone;

  @override
  Widget build(BuildContext context) {
    final stars = List.generate(
      rating.round(),
          (index) => const Icon(Icons.star, color: Colors.amber, size: 20),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.person_outline, size: 32, color: Colors.black54),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...stars,
              const SizedBox(width: 6),
              Text('($reviews avis)', style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 20, color: Colors.black54),
              const SizedBox(width: 6),
              Text(location, style: const TextStyle(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.phone_android, size: 20, color: Colors.black54),
              const SizedBox(width: 6),
              Text(phone, style: const TextStyle(color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: const [
              _ActionPill(icon: Icons.favorite_border, label: 'Favoris'),
              _ActionPill(icon: Icons.chat_bubble_outline, label: 'Message'),
              _ActionPill(icon: Icons.map_outlined, label: 'Localiser'),
              _ActionPill(icon: Icons.phone_in_talk_outlined, label: 'Appeler'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// EMERGENCY CARD
// ------------------------------------------------------------

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person_outline, size: 32, color: Colors.black54),
                SizedBox(height: 6),
                Icon(Icons.medical_services_outlined, size: 24, color: Colors.black54),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Docteur Seyba Ndiaye',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 18, color: Colors.black54),
                    SizedBox(width: 6),
                    Text(
                      'Hôpital Principal de Dakar',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone_android, size: 18, color: Colors.black54),
                    SizedBox(width: 6),
                    Text(
                      '+221 7 89 56 34 21',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------
// SECTION CARD (used in RDV, SETTINGS, etc.)
// ------------------------------------------------------------

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.88),
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 8)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 56, color: colorScheme.primary),
              const SizedBox(height: 14),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
