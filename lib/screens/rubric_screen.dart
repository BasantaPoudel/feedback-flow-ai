import 'package:flutter/material.dart';

class RubricScreen extends StatelessWidget {
  final List<String> texts;

  RubricScreen({required this.texts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rubric Screen'),
      ),
      body: ListView.builder(
        itemCount: texts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(texts[index]),
          );
        },
      ),
    );
  }
}
