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

/// Stateless because it only renders theme data and one screen — the theme and
/// student list are fixed, so the parent never has to rebuild it with new data.
class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Directory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
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
        padding: const EdgeInsets.all(16),
        children: [
          const SectionHeader(title: 'Students'),
          for (final student in students) StudentCard(student: student),
        ],
      ),
    );
  }
}

/// Stateless because it only draws a title it was given — text never changes
/// on its own, so the parent passes a new title if the heading should differ.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 4),
        const Divider(thickness: 2),
      ],
    );
  }
}

/// Stateless because all of its inputs (the Student) arrive through the
/// constructor; if the student changes, the parent rebuilds this widget.
class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: colors.secondaryContainer,
              foregroundColor: colors.onSecondaryContainer,
              child: Text(
                student.name[0],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    student.course,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 10),
                  InfoRow(
                    icon: Icons.school,
                    text: 'Year ${student.yearLevel}',
                  ),
                  InfoRow(
                    icon: Icons.email,
                    text: student.email,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Stateless because it is a pure presentation widget: given an icon and a
/// string it always renders the same thing, so the parent supplies new values.
class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
