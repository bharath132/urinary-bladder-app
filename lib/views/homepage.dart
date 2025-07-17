import 'package:flutter/material.dart';
import 'package:urinary_bladder_level/widgets/bladderGraph/bladderGraphLayout.dart';
import 'package:urinary_bladder_level/widgets/history.dart';
import 'package:urinary_bladder_level/widgets/infoCard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Urinary Bladder Level'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               InfoCard(),
        
               BladderGraphLayout(),
              const SizedBox(height: 16),
               History( ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}