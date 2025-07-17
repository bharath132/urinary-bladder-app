import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urinary_bladder_level/provider/bladderProvider.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // final formatter = ;

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Color.fromARGB(255, 109, 179, 235)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
      ),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 185,
      child: Selector<BladderProvider, String>(
        selector: (_, provider) => provider.userValue,
        builder: (context, value, _) {
          final percentage = (double.tryParse(value) ?? 0) * 100 / 2000;
          String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(Icons.water_drop, color: Colors.white, size: 30),
                  SizedBox(width: 8),
                  Text(
                    'Current Reading',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const Text(' ml', style: TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Last Updated: $formattedDate', style: const TextStyle(color: Colors.white70)),
                  Text('${percentage.toStringAsFixed(1)}%', style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (int.tryParse(value) ?? 0) / 2000.0,
                minHeight: 10,
                borderRadius: BorderRadius.circular(5),
                backgroundColor: Colors.white30,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
