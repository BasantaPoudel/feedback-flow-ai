import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // static final HomeScreenCubit instance = HomeScreenCubit();
  User? user = FirebaseAuth.instance.currentUser;
  var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');

  HomeScreenCubit() : super(UserLoadingState()) {
    getUserRole();
  }

  getUserRole() {
    final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);
    //Step-2 [use get to retrieve the results]
    query.get().then(
      (querySnapshot) {
        print("Query1 - Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          if (docSnapshot.data().containsValue("teacher")) {
            print("[Reached Teacher If]");
            emit(TeacherLoggedInState());
          } else {
            print("[Reached Student If]");
            emit(StudentLoggedInState());
            // loadStudentWidgets();
          }
          ;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
