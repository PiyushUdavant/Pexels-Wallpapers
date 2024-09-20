import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper_screen.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
} 


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      // ignore: prefer_const_constructors
      home: WallpaperScreen(),
    );
  }
}