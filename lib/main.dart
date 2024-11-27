import 'package:exam_prep_app/screens/notifications/notifications_screen.dart';
import 'package:exam_prep_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/study_material/study_material_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exam Preparation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        // '/scorecard': (context) => ScorecardScreen(),
        '/notifications': (context) => NotificationScreen(),
        '/study_material': (context) => StudyMaterialScreen(),
      },
    );
  }
}
