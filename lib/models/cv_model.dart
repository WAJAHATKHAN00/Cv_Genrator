import 'package:cloud_firestore/cloud_firestore.dart';

class CV {
  final String id;
  final String title;
  final DateTime createdAt;
  final String fullName;
  final String email;
  final String phone;
  final String summary;
  final List<String> education;
  final List<String> experience;
  final List<String> skills;

  CV({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.summary,
    required this.education,
    required this.experience,
    required this.skills,
  });

  factory CV.fromMap(Map<String, dynamic> map, String id) {
    return CV(
      id: id,
      title: map['title'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      summary: map['summary'] ?? '',
      education: List<String>.from(map['education'] ?? []),
      experience: List<String>.from(map['experience'] ?? []),
      skills: List<String>.from(map['skills'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'createdAt': Timestamp.fromDate(createdAt),
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'summary': summary,
      'education': education,
      'experience': experience,
      'skills': skills,
    };
  }
}
