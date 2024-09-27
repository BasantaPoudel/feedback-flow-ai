import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  final Logger log = Logger();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? databaseScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    return BlocBuilder<PresenterScreenCubit, PresenterScreenState>(
        builder: (context, state) {
      if (state is DatabaseScreenInitial || state is DatabaseScreenLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      var users = databaseScreenCubit.state.props;
      List<UserModel>? students =
          users?.where((element) => element.role == "student").toList();
      return ListView.builder(
          itemCount: students?.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                color: const Color(0xFF6D7981),
                child: ListTile(
                    title: Text(students![index].name),
                    textColor: Colors.white,
                    trailing:
                        BlocBuilder<PresenterScreenCubit, PresenterScreenState>(
                            builder: (context, state) {
                      if (state is PresenterState) {
                        return Checkbox(
                          value: students[index].isPresenter,
                          checkColor: Colors.white,
                          onChanged: (bool? value) {
                            databaseScreenCubit.selectPresenter(
                                students, index);
                          },
                        );
                      } else {
                        log.d("Reached Else");

                        return Checkbox(
                            value: false,
                            onChanged: (bool? value) => databaseScreenCubit
                                .selectPresenter(students, index));
                      }
                    })));
          });
    });
  }
}
