import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/rubric.dart';

class RubricsRepository {
  final FirebaseFirestore _firestore;

  RubricsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Rubric>> fetchRubrics() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('rubrics').get();
      return snapshot.docs.map((doc) => Rubric.fromDocument(doc)).toList();
    } catch (e) {
      throw Exception('Error fetching rubricss: $e');
    }
  }

  addRubrics(String title, String description) async {
    try {
      await _firestore.collection('rubrics').add({
        'title': title,
        'description': description,
      });
    } catch (e) {
      throw Exception('Error adding rubrics: $e');
    }
  }
}
