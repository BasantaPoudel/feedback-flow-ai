import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  List<String> users = []; // List of users from the database
  // List<bool> isPresenter = []; // List to track if a user is a presenter

  @override
  void initState() {
    super.initState();
    // Fetch users from the database and populate the lists
    fetchUsersFromDatabase();
  }

  @override
  void fetchUsersFromDatabase() {
    var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');

    roleBasedUsersRef.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> user = doc.data()! as Map<String, dynamic>;
        users.add(user['email']);
        // isPresenter.add(doc['isPresenter']);
      });
    });
    // Implement your logic to fetch users from the Cloud Firestore database
    // and populate the 'users' and 'isPresenter' lists accordingly
    // For example:
    // users = ['User 1', 'User 2', 'User 3'];
    // isPresenter = [false, true, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]),
            // trailing: Checkbox(
            //   value: isPresenter[index],
            //   onChanged: (value) {
            //     setState(() {
            //       isPresenter[index] = value;
            //     });
            //   },
            // ),
          );
        },
      ),
    );
  }
}
