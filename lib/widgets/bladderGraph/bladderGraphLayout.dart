import 'package:flutter/material.dart';

import 'package:urinary_bladder_level/widgets/bladderGraph/bladderGraph.dart';

class BladderGraphLayout extends StatelessWidget {
  const BladderGraphLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // chart
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.only(left: 0, right: 16, top: 0, bottom: 0),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: BladderGraph(),
    );
  }
}
