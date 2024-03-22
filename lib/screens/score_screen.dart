import 'package:feedback_flow/repository/score_repository.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  int _score2 = 0;
  int _score1 = 0;
  void _sendScoreToFirebase(score1, score2) {
    // Send the score to Firebase database
    _scoreRepository.sendScoreToFirebase(score1, score2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Screen'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Rubric 1'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    icon: const Icon(Icons.star),
                    color: _score1 >= i ? Colors.yellow : Colors.grey,
                    onPressed: () {
                      setState(() {
                        _score1 = i;
                      });
                      _sendScoreToFirebase(_score1, _score2);
                    },
                  ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Rubric 2'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= 5; i++)
                  IconButton(
                    icon: const Icon(Icons.star),
                    color: _score2 >= i ? Colors.yellow : Colors.grey,
                    onPressed: () {
                      setState(() {
                        _score2 = i;
                      });
                      _sendScoreToFirebase(_score1, _score2);
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
