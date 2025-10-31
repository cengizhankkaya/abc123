// import 'package:abcproject/presentation/screens/draw_screen.dart.dart';
import 'package:abc123/features/home/presentation/screens/home_screen.dart';
import 'package:abc123/features/letters/presentation/screens/letter_drawing_provider.dart';
import 'package:abc123/core/services/audio_service.dart';
import 'package:abc123/shared/counter_provider.dart';
import 'package:abc123/shared/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // SystemChrome için eklendi
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/utils/screen_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // WidgetsFlutterBinding'i başlat
  await MobileAds.instance.initialize();
  // Uygulamayı yalnızca dikey (portre) modunda çalıştır
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DrawingProvider()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ChangeNotifierProvider(create: (_) => CounterProvider()),
        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Arka plana geçildiğinde arka plan müziğini durdur
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      AudioService().stopBackground();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      title: 'Rakam Tanıma Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          secondary: Colors.amber,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
