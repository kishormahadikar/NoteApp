import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/notesModel.dart';
import 'models/notesModel.dart';
import 'widgets/noteFormm.dart';
import 'screens/notesScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'NoteIt';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteIt',
      home: NotesPage(),
      theme: ThemeData.dark(),
    );
  }
}
