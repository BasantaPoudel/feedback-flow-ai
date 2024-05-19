import 'package:firebase_auth/firebase_auth.dart';

abstract class MainRepository {
  User? user = FirebaseAuth.instance.currentUser;

  MainRepository();
}
