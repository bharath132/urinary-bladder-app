import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urinary_bladder_level/core/services/notificationService.dart';
import 'package:urinary_bladder_level/provider/bladderProvider.dart';
import 'package:urinary_bladder_level/views/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the notification service
   await NotificationService().initNotification(); 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BladderProvider()..startTimer()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

