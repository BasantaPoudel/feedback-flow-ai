import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  // List<String> users = []; // List of users from the database
  Future<List<String>>? _operationResult;
  // List<bool> isPresenter = List.filled(_operationResult[].length, false, growable: true);; // List to track if a user is a presenter
  @override
  void initState() {
    super.initState();
    // Fetch users from the database and populate the lists
    // performFetch();
  }

  void getUsers() {
    setState(() {
      _operationResult = fetchUsersFromDatabase();
    });
  }

  // Future<List<String>>? performFetch() {
  //   _operationResult = fetchUsersFromDatabase();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20.0), //The distance you want
        child: ElevatedButton(
          child: Text(
            'Get Users',
          ),
          onPressed: getUsers,
        ),
      ),
      FutureBuilder(
          future: _operationResult,
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Waiting for an operation result.");
            } else if (snapshot.hasError) {
              return Text("Error in operation: ${snapshot.error}");
            } else if (!snapshot.hasData) {
              return const Text("No operation result yet.");
            } else {
              List<String> users = snapshot.data!;

              return Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(users[index]),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ));
                  },
                ),
              );
            }
          }),
    ]);
  }
}

Future<List<String>> fetchUsersFromDatabase() async {
  List<String> users = [];
  // List<String> users = ['Basanta', 'Santosh', 'Suman'];
  try {
    var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
    await roleBasedUsersRef.get().then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> user = doc.data()! as Map<String, dynamic>;
        users.add(user['email']);
      });
    });
  } catch (e) {
    print('Error: $e');
  }
  return users;
}
