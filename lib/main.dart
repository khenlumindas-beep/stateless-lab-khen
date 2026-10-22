import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp()); // sinugdanan sa app

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

// listahan sa estudyante; matag butang = usa ka card sa screen
const List<Student> students = [
  Student(
    name: 'Potcolo gonzales',
    course: 'BS Computer Science',
    yearLevel: 3,
    email: 'potcolo.gonzales@university.edu',
  ),
  Student(
    name: 'Elias zambales',
    course: 'BS Information Technology',
    yearLevel: 2,
    email: 'elias.zambales@university.edu',
  ),
  Student(
    name: 'Rene Valdez',
    course: 'BS Electronics Engineering',
    yearLevel: 4,
    email: 'rene.valdez @university.edu',
  ),
  Student(
    name: 'Rico Villanueva ',
    course: 'BS Mathematics',
    yearLevel: 1,
    email: 'rico.villanueva@university.edu',
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

class DirectoryApp extends StatelessWidget {
  const DirectoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Directory',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        // kini ang kolor nga basihan sa tibuok app (appbar, icon, text)
        colorSchemeSeed: const Color.fromARGB(255, 116, 2, 35),
        useMaterial3: true,

        cardTheme: const CardThemeData( // hugot ang lingin sa ngutngut sa card
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),

        textTheme: const TextTheme(
          bodyMedium: TextStyle(height: 1.35), // mas duol ang linya sa text
        ),
      ),
      home: const DirectoryScreen(), // ang screen nga mobukas
    );
  }
}

class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // ang tibuok layout sa screen
      appBar: AppBar( // taas nga bar sa ibabaw
        title: const Text('Campus Directory'), // ang title nga mobasa sa bar
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView( // dinhi mo-scroll ang listahan sa mga card
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24), // kahilom sa sulod
        children: [
          const SectionHeader(title: 'Students'), // ang "Students" nga heading

          for (final student in students) StudentCard(student: student), // matag student = usa ka card
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column( // gilatid: heading + linya sa ilalom
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text( // ang pulong nga "Students" (bold, colored)
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 4), // gamayng space
        const Divider(thickness: 2), // ang linya sa ilalom sa heading
      ],
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card( // ang kahon sa matag estudyante
      margin: const EdgeInsets.only(bottom: 12), // space tali sa mga card
      child: Padding(
        padding: const EdgeInsets.all(16), // sulod nga kahilom sa card
        child: Row( // kaliwa: avatar, tuo: mga text
          children: [
            CircleAvatar( // ang bulot nga naay unang letter sa ngalan
              radius: 26,
              backgroundColor: colors.secondaryContainer,
              foregroundColor: colors.onSecondaryContainer,
              child: Text(
                student.name[0], // unang letter lang, e.g. "P" sa Potcolo
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16), // space tali sa avatar ug text
            Expanded( // para dili mo-overflow ang text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( // ang NGALAN sa estudyante (bold)
                    student.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text( // ang KURSO, e.g. BS Computer Science
                    student.course,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 10),
                  InfoRow( // "Year 3" + icon sa graduation cap
                    icon: Icons.school,
                    text: 'Year ${student.yearLevel}',
                  ),
                  InfoRow( // ang email + email icon
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

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4), // gamayng space sa ilalom
      child: Row( // icon + text pareho sa linya
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary), // gamayng icon
          const SizedBox(width: 8), // gap tali sa icon ug text
          Expanded(
            child: Text( // ang teksto, e.g. "Year 3" o ang email
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
