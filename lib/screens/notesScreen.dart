import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../database/dbbb.dart';
import '../models/notesModel.dart';
import 'editNote_screen.dart';
import 'noteDetails_screen.dart';
import '../widgets/noteCard.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEditNotePage()),
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text(
                          'No Notes Added',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    )
                  : buildNotes(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.black26,
          backgroundColor: Colors.black,
          child: Icon(Icons.add, color: Colors.red),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(10),
        itemCount: notes.length,
        staggeredTileBuilder: (i) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 20,
        itemBuilder: (context, i) {
          final note = notes[i];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: i),
          );
        },
      );
}
