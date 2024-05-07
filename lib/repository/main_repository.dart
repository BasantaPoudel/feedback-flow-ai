import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class MainRepository {
  User? user = FirebaseAuth.instance.currentUser;

  MainRepository();
}
