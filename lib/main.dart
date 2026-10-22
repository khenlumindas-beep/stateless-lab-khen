import 'package:flutter/material.dart';

void main() => runApp(const DirectoryApp()); // sinugdanan sa app

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
/// Bisaya: kini ang listahan sa estudyante nga mo-gawas matag usa ka card.
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
        // ang kolor niini ang basihan sa tibuok app (appbar, icon, text)
        colorSchemeSeed: const Color.fromARGB(255, 116, 2, 35),
        useMaterial3: true,
        // CUSTOMIZATION 2: rounded 18 px card corners applied to every Card.
        cardTheme: const CardThemeData( // hugot ang lingin sa ngutngut sa card
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
        ),
        // CUSTOMIZATION 3: tighter default text theme for a denser directory look.
        textTheme: const TextTheme(
          bodyMedium: TextStyle(height: 1.35),
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
      // CUSTOMIZATION 4: AppBar tinted from the theme's primary container color.
      appBar: AppBar( // taas nga bar sa ibabaw
        title: const Text('Campus Directory'), // ang title nga mobasa sa bar
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView( // dinhi mo-scroll ang listahan sa mga card
        // CUSTOMIZATION 5: extra breathing room around the whole list.
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24), // luyo nga kahilom sa sulod
        children: [
          const SectionHeader(title: 'Students'), // ang "Students" nga heading
          // The parent maps the data into widgets; when the list changes the
          // parent rebuilds this widget with a different set of children.
          for (final student in students) StudentCard(student: student), // matag student = usa ka card
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
    return Column( // gilatid: heading + linya sa ilalom
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CUSTOMIZATION 6: heading styled bold and colored from the theme seed.
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

/// Stateless because all of its inputs (the Student) arrive through the
/// constructor; if the student changes, the parent rebuilds this widget.
class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

    return Card( // ang puti nga kahon sa matag estudyante
      margin: const EdgeInsets.only(bottom: 12), // space tali sa mga card
      child: Padding(
        padding: const EdgeInsets.all(16), // sulod nga kahilom sa card
        child: Row( // kaliwa: avatar, tuo: mga text
          children: [
            // CUSTOMIZATION 7: avatar tinted with the theme's secondary color.
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
            Expanded( // para dili mo-overflow ang text sa kahon
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CUSTOMIZATION 8: name given its own bold, larger text style.
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
                  InfoRow( // ang email address + email icon
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
      padding: const EdgeInsets.only(bottom: 4), // gamayng space sa ilalom
      child: Row( // icon + text pareho sa linya
        children: [
          Icon(icon, size: 16, color: Theme.of(context).colorScheme.primary), // ang gamayng icon
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
