import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCVPage extends StatefulWidget {
  const AddCVPage({super.key});

  @override
  State<AddCVPage> createState() => _AddCVPageState();
}

class _AddCVPageState extends State<AddCVPage> {
  final TextEditingController _titleController = TextEditingController();
  bool _isLoading = false;

  Future<void> _saveCV() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('cvs').add({
        'title': title,
        'createdAt': Timestamp.now(),
      });

      if (!mounted) return;
      Navigator.of(context).pop(true); // Return to Library Page
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving CV: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New CV')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'CV Title'),
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _saveCV,
              child: const Text('Save CV'),
            ),
          ],
        ),
      ),
    );
  }
}
