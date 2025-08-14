import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hr_self_service/src/data/services/app_lock_service.dart';
import 'package:hr_self_service/src/ui/login/login_screen.dart';
import 'package:hr_self_service/src/ui/settings/setting_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  bool _locked = true;
  bool _authenticating = false;
  final _appLockService = AppLockService();
  DateTime? _backgroundedAt;
  final Duration lockThreshold = const Duration(seconds: 10);

  _MyAppState() {
    didChangeAppLifecycleState(AppLifecycleState.resumed);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (_backgroundedAt == null &&
      (state == AppLifecycleState.paused || state == AppLifecycleState.inactive)) {
      
      // Only record if there is no previous record
      _backgroundedAt = DateTime.now();
    }
    
    if (state == AppLifecycleState.resumed) {
      if (_backgroundedAt != null && DateTime.now().difference(_backgroundedAt!) > lockThreshold) {
        setState(() => _locked = true);
      }

      if (_locked) {
        _authenticating = true;
        final unlocked = await _appLockService.authenticate();
        setState(() => _locked = !unlocked);
        _authenticating = false;
      }

      _backgroundedAt = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedSettingAsync = ref.watch(savedSettingProvider);
    final settings = ref.watch(settingProvider);

    // Load the saved settings into the global settings
    savedSettingAsync.whenData((setting) => ref.read(settingProvider.notifier).state = setting);

    return MaterialApp(
      title: 'HR Self Service',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: settings.seedColor),
        fontFamily: settings.fontFamily,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: settings.seedColor, brightness: Brightness.dark),
        fontFamily: settings.fontFamily,
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.system,
      home: _locked
      ? Scaffold(
        body: Center(
          child: _authenticating
          ? CircularProgressIndicator()
          : Text('Please Authenticate')
        )
        )
      : const LoginScreen()
    );
  }
}