import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/notesModel.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;
  
  @override
  Widget build(BuildContext context) {
    final heightt = getheightt(index);
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    
    return Card(
      
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [color.withOpacity(0.4), color]),
            borderRadius: BorderRadius.circular(20)),
        constraints: BoxConstraints(minHeight: heightt),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                time,
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 4),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                note.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ], 
        ),
      ),
    );
  }
  double getheightt(int index) {
    return 100;
    
  }
}
