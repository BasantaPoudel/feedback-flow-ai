import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  int _score2 = 0;
  int _score1 = 0;
  final _databaseRef = FirebaseFirestore.instance.collection('scores');
  User? user = FirebaseAuth.instance.currentUser;

  void _sendScoreToFirebase() {
    // Send the score to Firebase database
    _databaseRef.where("provider", isEqualTo: user!.email).get().then((value) {
      if (value.docs.isEmpty) {
        _databaseRef.add({
          'provider': user!.email,
          'score1': _score1,
          'score2': _score2,
        });
      } else {
        _databaseRef
            .doc(value.docs.first.id)
            .update({'score1': _score1, 'score2': _score2});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Screen'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Rubric 1'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    icon: Icon(Icons.star),
                    color: _score1 >= i ? Colors.yellow : Colors.grey,
                    onPressed: () {
                      setState(() {
                        _score1 = i;
                      });
                      _sendScoreToFirebase();
                    },
                  ),
              ],
            ),
          ),
          ListTile(
            title: Text('Rubric 2'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    icon: Icon(Icons.star),
                    color: _score2 >= i ? Colors.yellow : Colors.grey,
                    onPressed: () {
                      setState(() {
                        _score2 = i;
                      });
                      _sendScoreToFirebase();
                    },
                  ),
              ],
            ),
          ),
          // Add more rubrics here
        ],
      ),
    );
  }
}
