import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MainRepository {
  final roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
  final databaseRef = FirebaseFirestore.instance.collection('scores');
  User? user = FirebaseAuth.instance.currentUser;

  MainRepository();
}
