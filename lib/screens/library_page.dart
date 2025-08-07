import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cv_model.dart';
import '../widgets/cv_item.dart';
import 'add_cv_page.dart';
import 'edit_cv_page.dart';
import 'view_cv_page.dart'; // ✅ Import the view page

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My CVs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCVPage()),
              );

              if (result == true) {
                setState(() {});
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cvs')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('No CVs found.'));
          }

          final cvs = docs.map((doc) {
            return CV.fromMap(doc.data() as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: cvs.length,
            itemBuilder: (context, index) {
              final cv = cvs[index];
              return CVItem(
                cv: cv,
                onDelete: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete CV'),
                      content: const Text('Are you sure you want to delete this CV?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true) {
                    await FirebaseFirestore.instance
                        .collection('cvs')
                        .doc(cv.id)
                        .delete();
                  }
                },
                onEdit: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditCVPage(cv: cv)),
                  );

                  if (result == true) {
                    setState(() {});
                  }
                },
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ViewCVPage(cv: cv)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
