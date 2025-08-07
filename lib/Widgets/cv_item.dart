import 'package:flutter/material.dart';
import '../models/cv_model.dart';
import '../screens/view_cv_page.dart';
import '../screens/edit_cv_page.dart';

class CVItem extends StatelessWidget {
  final CV cv;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onView;

  const CVItem({
    super.key,
    required this.cv,
    required this.onDelete,
    required this.onEdit,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cv.title),
      subtitle: Text(
        '${cv.createdAt.day}-${cv.createdAt.month}-${cv.createdAt.year}',
        style: const TextStyle(fontSize: 12),
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'view') {
            onView(); // Delegated to parent
          } else if (value == 'edit') {
            onEdit(); // Delegated to parent
          } else if (value == 'delete') {
            onDelete(); // Confirmed in parent
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'view', child: Text('View')),
          PopupMenuItem(value: 'edit', child: Text('Edit')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }
}
