# Campus Student Directory

**Name:** Khen
**Activity:** Stateless Widgets Laboratory — Campus Student Directory (Flutter)

A one-screen Flutter app that shows a directory of students built entirely from
small, reusable `StatelessWidget` classes. No `StatefulWidget` and no
`setState` is used anywhere: all data is hard-coded and flows into each widget
through its constructor.

## Widgets

| Widget | Responsibility |
| --- | --- |
| `Student` | Immutable data class (`final` fields, `const` constructor) |
| `DirectoryApp` | `MaterialApp` with a teal `colorSchemeSeed`, Material 3 |
| `DirectoryScreen` | `Scaffold`, `AppBar` and `ListView` of student cards |
| `SectionHeader` | Bold colored heading with a `Divider` below |
| `StudentCard` | `Card` with `CircleAvatar`, name, course and two `InfoRow`s |
| `InfoRow` | Icon + text side by side in a `Row` |

## Screenshot

![App screenshot](screenshots/app.png)

## Run it

```bash
flutter pub get
flutter run
```
