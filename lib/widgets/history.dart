import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/bladderProvider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final bladderProvider = context.watch<BladderProvider>();
    final historyList = bladderProvider.history;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.history, size: 30),
              SizedBox(width: 8),
              Text(
                'Recent History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // List
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            final entry = historyList[index];
            return Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.water_drop_sharp,
                  color: Color.fromARGB(255, 0, 138, 252),
                ),
                title: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${entry['value']} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const TextSpan(
                        text: 'ml',
                        style: TextStyle(
                          color: Color(0xFF015AFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Text(
                  entry['time'],
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            );
          },
        ),

        // Load More Button
        if (bladderProvider.hasMoreHistory)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 109, 179, 235)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: TextButton.icon(
                onPressed: () => bladderProvider.loadMoreHistory(),
                icon: const Icon(Icons.expand_more , color: Colors.white),
                label: const Text(
                  "Load More",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        // Load Less Button
        if (bladderProvider.hasLessHistory)
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blue, Color.fromARGB(255, 109, 179, 235)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)],
              ),
              child: TextButton.icon(
                onPressed: () {
                  bladderProvider.loadLessHistory(); // Reset to first page
                },
                icon: const Icon(Icons.expand_less , color: Colors.white),
                label: const Text(
                  "Load Less",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
