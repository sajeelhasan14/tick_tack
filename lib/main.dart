import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tick_tack/UI/screens/stopwatch_screen.dart';
import 'package:tick_tack/UI/theme/app_theme.dart';
import 'package:tick_tack/provider/stopwatch_provider.dart';

void main() {
   runApp(
    ChangeNotifierProvider(
      create: (_) => StopwatchProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: "TickTack",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const StopWatchScreen(),
    );
      
    
  }
}




