import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ActivitiesScreenCubit, ActivitiesScreenState>(
        listener: (context, state) {
      if (state is ActivityErrorLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load items')),
        );
      }
    }, child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
      return Scaffold(
          body: ListView(
        children: <Widget>[
          Container(
              // height: MediaQuery.of(context).size.height * 0.2,
              // width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromRGBO(207, 216, 220, 1),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(70)),
              ),
              child: ListTile(
                title: const Text('Past In Class Activities'),
                subtitle: ListBuilder(),
              )),
          BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
              builder: (context, stateActivity) {
            List<Activity>? activitiesList = stateActivity.getAllActivities;
            return Container(
                // height: MediaQuery.of(context).size.height * 0.2,
                // width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: ListTile(
                  title: const Text('Upcoming In Class Activities'),
                  subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activitiesList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        if (activitiesList![index].isDistributed == false) {
                          return Card(
                              color: activitiesList[index].isStarted
                                  ? Colors.green
                                  : const Color(0xFF6D7981),
                              child: ListTile(
                                title: Text(
                                  activitiesList[index].title,
                                  style: const TextStyle(
                                    color: Colors
                                        .white, // Change text color to white
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RubricScreen(
                                          activity: activitiesList[index]),
                                    ),
                                  );
                                },
                              ));
                        }
                        return const FittedBox(); // return null;
                      }),
                ));
          }),
        ],
      ));
    }));
  }
}
