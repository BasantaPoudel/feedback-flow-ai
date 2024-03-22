import 'package:flutter/material.dart';

class RubricScreen extends StatelessWidget {
  final List<String> texts;

  const RubricScreen({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rubric Screen'),
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
