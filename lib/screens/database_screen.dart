import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  // List<String> users = []; // List of users from the database
  //TODO - Change the futurebuilder to BlocBuilder completely by transfering the business logic to the repository
  Future<List<UserModel>>? _operationResult;
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
    // DatabaseScreenCubit? _databaseScreenCubit =
    // BlocProvider.of<DatabaseScreenCubit>(context);

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
              (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Waiting for an operation result.");
            } else if (snapshot.hasError) {
              return Text("Error in operation: ${snapshot.error}");
            } else if (!snapshot.hasData) {
              return const Text("No operation result yet.");
            } else {
              List<UserModel> users = snapshot.data!;
              // bool isPresenter = false;
              return BlocProvider(
                  create: (_) => DatabaseScreenCubit(),
                  child: Expanded(
                      child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                                title: Text(users[index].email),
                                trailing: BlocBuilder<DatabaseScreenCubit,
                                        DatabaseScreenState>(
                                    builder: (context, state) {
                                  if (state is PresenterState) {
                                    return Checkbox(
                                      value: state.props![index].isPresenter,
                                      onChanged: (bool? value) {
                                        context
                                            .read<DatabaseScreenCubit>()
                                            .selectPresenter(users, index);
                                      },
                                    );
                                  } else {
                                    print("Reached Else");

                                    return Checkbox(
                                        value: false,
                                        onChanged: (bool? value) => context
                                            .read<DatabaseScreenCubit>()
                                            .selectPresenter(users, index));
                                  }
                                }));
                          })));
            }
          }),
    ]);
  }
}

Future<List<UserModel>> fetchUsersFromDatabase() async {
  List<UserModel> users = [];
  // List<String> users = ['Basanta', 'Santosh', 'Suman'];
  try {
    var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
    await roleBasedUsersRef.get().then((QuerySnapshot querySnapshot) async {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> user = doc.data()! as Map<String, dynamic>;
        users.add(UserModel.fromMap(user));
      });
    });
  } catch (e) {
    print('Error: $e');
  }
  return users;
}
