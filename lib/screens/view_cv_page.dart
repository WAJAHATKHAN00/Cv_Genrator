import 'package:flutter/material.dart';
import '../models/cv_model.dart';

class ViewCVPage extends StatelessWidget {
  final CV cv;

  const ViewCVPage({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CV Details')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${cv.title}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(
              'Created: ${cv.createdAt.day}-${cv.createdAt.month}-${cv.createdAt.year}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
