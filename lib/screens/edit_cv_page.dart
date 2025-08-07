import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cv_model.dart';

class EditCVPage extends StatefulWidget {
  final CV cv;

  const EditCVPage({super.key, required this.cv});

  @override
  State<EditCVPage> createState() => _EditCVPageState();
}

class _EditCVPageState extends State<EditCVPage> {
  late TextEditingController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.cv.title);
  }

  Future<void> _updateCV() async {
    final newTitle = _controller.text.trim();
    if (newTitle.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('cvs')
          .doc(widget.cv.id)
          .update({'title': newTitle});

      if (!mounted) return;
      Navigator.pop(context); // back to library
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit CV')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _controller),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _updateCV,
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
