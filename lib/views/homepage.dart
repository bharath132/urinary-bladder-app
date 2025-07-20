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
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              InfoCard(),
        
              BladderGraphLayout(),
              SizedBox(height: 16),
              History(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
