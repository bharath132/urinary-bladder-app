import 'package:flutter/material.dart';
import 'package:urinary_bladder_level/core/services/notificationService.dart';
import 'package:urinary_bladder_level/widgets/bladderGraph/bladderGraphLayout.dart';
import 'package:urinary_bladder_level/widgets/history.dart';
import 'package:urinary_bladder_level/widgets/infoCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        toolbarHeight: 80,
        title: const Text(
          'Urinary Bladder Level',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 138, 252),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FloatingActionButton(onPressed: (){
              NotificationService().showNotification(
                title: ' ⚠️ Test Notification',
                body: 'This is a test notification from the app.',
              );
            }, backgroundColor: const Color.fromARGB(255, 0, 138, 252), child: const Icon(Icons.refresh)),
            InfoCard(),

            BladderGraphLayout(),
            const SizedBox(height: 16),
            History(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
