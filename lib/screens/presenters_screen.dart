import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';

class PresentersScreen extends StatefulWidget {
  const PresentersScreen({super.key});

  @override
  State<PresentersScreen> createState() => _PresentersScreenState();
}

class _PresentersScreenState extends State<PresentersScreen> {
  final Logger log = Logger();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PresenterScreenCubit, PresenterScreenState>(
        builder: (context, state) {
      if (state is PresenterScreenInitial || state is PresenterScreenLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      var users = context.read<PresenterScreenCubit>().state.props;
      List<UserModel>? students =
          users?.where((element) => element.role == "student").toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text("Enrolled Students"),
        ),
        body: BlocBuilder<ActScreenCubit, ActScreenState>(
            builder: (context, stateActivity) {
          return ListView.builder(
              itemCount: students?.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: const Color(0xFF6D7981),
                    child: ListTile(
                        title: Text(students![index].name),
                        textColor: Colors.white,
                        trailing: BlocBuilder<PresenterScreenCubit,
                            PresenterScreenState>(builder: (context, state) {
                          if (state is PresenterState &&
                              stateActivity is ActivityStarted) {
                            return Checkbox(
                              value: students[index].isPresenter,
                              checkColor: Colors.white,
                              onChanged: null,
                            );
                          } else {
                            log.d("Reached False");
                            return Checkbox(
                                value: students[index].isPresenter,
                                onChanged: (bool? value) => context
                                    .read<PresenterScreenCubit>()
                                    .selectPresenter(students, index));
                          }
                        })));
              });
        }),
      );
    });
  }
}
