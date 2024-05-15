import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/result_screen/result_screen_cubit.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/results_screen.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/models/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilder extends StatefulWidget {
  @override
  _ListBuilderState createState() => _ListBuilderState();
  final List<Activity> activitiesList;
  const ListBuilder({Key? key, required this.activitiesList}) : super(key: key);
}

class _ListBuilderState extends State<ListBuilder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActScreenCubit, ActScreenState>(
        builder: (context, stateActivity) {
      List<Activity>? activitiesList = stateActivity.getAllActivities;
      final ScrollController scrollController = ScrollController();

      return ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: activitiesList?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          if (activitiesList![index].isDistributed == true) {
            return Card(
                color: const Color.fromARGB(255, 231, 196, 191),
                child: ListTile(
                  title: Text(
                    activitiesList[index].title,
                    style: const TextStyle(
                      color: Colors.white, // Change text color to white
                    ),
                  ),
                  onTap: () {
                    //TODO - Check if this is the right way to pass data
                    context
                        .read<ResultScreenCubit>()
                        .calculateAndLoadActivity(activitiesList[index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultsScreen(),
                      ),
                    );
                  },
                ));
          } else if (activitiesList[index].isDistributed == false) {}
          return const FittedBox();
        },
      );
    });
  }
}
