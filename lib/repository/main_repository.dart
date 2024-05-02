import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MainRepository {
  final roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
  final scoreRef = FirebaseFirestore.instance.collection('scores_received');
  final activitiesRef = FirebaseFirestore.instance.collection('act');
  final activitiesRef3 = FirebaseFirestore.instance.collection('newActivities');
  final activitiesRef2 = FirebaseFirestore.instance.collection('activities');
  User? user = FirebaseAuth.instance.currentUser;

  MainRepository();
}
