// import 'package:abcproject/presentation/screens/draw_screen.dart.dart';
import 'package:abc123/presentation/providers/language_provider.dart';
import 'package:abc123/presentation/providers/letter_drawing_provider.dart';
import 'package:abc123/presentation/screens/homescreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // SystemChrome için eklendi
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'presentation/providers/counter_provider.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
