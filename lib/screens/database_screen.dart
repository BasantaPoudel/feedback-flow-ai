import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  //TODO - Change the futurebuilder to BlocBuilder completely by transfering the business logic to the repository
  Future<List<UserModel>>? _operationResult;
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    // Fetch users from the database and populate the lists
    getUsers();
  }

  void getUsers() {
    setState(() {
      _operationResult = _userRepository.fetchUsersFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseScreenCubit? databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

    return BlocProvider(
        create: (context) => DatabaseScreenCubit()..subscribeToData(),
        child: FutureBuilder(
            future: _operationResult,
            builder: (BuildContext context,
                AsyncSnapshot<List<UserModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Waiting for an operation result.");
              } else if (snapshot.hasError) {
                return Text("Error in operation: ${snapshot.error}");
              } else if (!snapshot.hasData) {
                return const Text("No operation result yet.");
              } else {
                List<UserModel> users = snapshot.data!;
                // bool isPresenter = false;
                return Expanded(
                    child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: const Color(0xFF6D7981),
                              child: ListTile(
                                  title: Text(users[index].name),
                                  textColor: Colors.white,
                                  trailing: BlocBuilder<DatabaseScreenCubit,
                                          DatabaseScreenState>(
                                      builder: (context, state) {
                                    if (state is PresenterState) {
                                      return Checkbox(
                                        value: state.props![index].isPresenter,
                                        checkColor: Colors.white,
                                        onChanged: (bool? value) {
                                          databaseScreenCubit.selectPresenter(
                                              users, index);
                                        },
                                      );
                                    } else {
                                      print("Reached Else");

                                      return Checkbox(
                                          value: false,
                                          onChanged: (bool? value) =>
                                              databaseScreenCubit
                                                  .selectPresenter(
                                                      users, index));
                                    }
                                  })));
                        }));
              }
            }));
  }
}
