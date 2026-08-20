import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'screen/splash_screen.dart';
import 'models/fitness_activity.dart';
import 'services/hive_service.dart';
import 'providers/fitness_provider.dart';

void main() async {
  // Flutter engine ko ready hone do taaki async code smoothly chale
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Initialize karo
  await Hive.initFlutter();

  // Generated Adapter register karo
  Hive.registerAdapter(FitnessActivityAdapter());

  // Database box open karo
  await Hive.openBox<FitnessActivity>(HiveService.boxName);

  runApp(
    ChangeNotifierProvider(
      create: (context) => FitnessProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}