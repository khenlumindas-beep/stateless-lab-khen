import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp());

/// Immutable student record — every field is final, so the data never changes
/// after it is created and can be shared safely by stateless widgets.
class Student {
  final String name;
  final String course;
  final int yearLevel;
  final String email;

  const Student({
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.email,
  });
}

/// Hard-coded directory data; there is no user input, so the list is constant.
const List<Student> students = [
  Student(
    name: 'Angela Dizon',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'angela.dizon@university.edu',
  ),
  Student(
    name: 'Marco Reyes',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'marco.reyes@university.edu',
  ),
  Student(
    name: 'Bea Santos',
    course: 'BS Electronics Engineering',
    yearLevel: 4,
    email: 'bea.santos@university.edu',
  ),
  Student(
    name: 'Carlo Villanueva',
    course: 'BS Mathematics',
    yearLevel: 1,
    email: 'carlo.villanueva@university.edu',
  ),
  Student(
    name: 'Diana Lim',
    course: 'BS Business Administration',
    yearLevel: 3,
    email: 'diana.lim@university.edu',
  ),
  Student(
    name: 'Ethan Cruz',
    course: 'BS Mechanical Engineering',
    yearLevel: 2,
    email: 'ethan.cruz@university.edu',
  ),
];

/// Stateless because it only renders a fixed screen — nothing here changes on
/// its own, so the parent never has to rebuild it with new data.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Directory',
      home: const DirectoryScreen(),
    );
  }
}

/// Stateless because the screen is a fixed layout: its data comes from the
/// constant `students` list, so only a parent could ever supply new data.
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Directory')),
      body: ListView(
        children: [
          for (final student in students)
            ListTile(
              title: Text(student.name),
              subtitle: Text(student.course),
            ),
        ],
      ),
    );
  }
}
