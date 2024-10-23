import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/repository/rubric_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddActivity extends StatefulWidget {
  const AddActivity({super.key});

  @override
  State<AddActivity> createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  List<Rubric> _selectedRubrics = [];

  @override
  void initState() {
    super.initState();
  }

  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerNewRubric = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ActScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActScreenCubit>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add activity'),
        ),
        body: FutureBuilder<List<Rubric>>(
            future: fetchDataFromDatabase(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Rubric>> snapshot) {
              if (snapshot.hasData) {
                var children = <Widget>[
                  TextField(
                    controller: _controllerTitle,
                    enabled: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter activity title',
                    ),
                    maxLines: null,
                  ),

                  const SizedBox(height: 10),
                  //################################################################################################
                  // Rounded blue MultiSelectDialogField -
                  //################################################################################################
                  MultiSelectDialogField(
                    searchable: true,
                    items: snapshot.data!
                        .map((rubrics) =>
                            MultiSelectItem<Rubric>(rubrics, rubrics.title))
                        .toList(),
                    initialValue: calulateInitialValue(
                        _selectedRubrics,
                        snapshot
                            .data!), // setting the value of the MultiSelectField
                    title: const Text("Rubrics"),
                    selectedColor: Colors.blue,
                    chipDisplay: MultiSelectChipDisplay.none(),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.blue,
                    ),
                    buttonText: Text(
                      "Select Rubrics From List",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        _selectedRubrics = results.cast<Rubric>();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        showAlertDialog(context, activitiesScreenCubit.state);
                      },
                      child: const Text(
                        'Create New Rubric',
                      ),
                    ),
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    height: 40,
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: _selectedRubrics.map((item) {
                      return Chip(
                        label: Text(item.title),
                        backgroundColor: Colors.blue[100],
                        deleteIcon: const Icon(Icons.cancel,
                            color: Colors.red), // Custom delete icon
                        onDeleted: () {
                          setState(() {
                            _selectedRubrics.remove(
                                item); // Remove the item from the selected list
                          });
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {
                        if (_controllerTitle.text.trim().isEmpty) return;

                        try {
                          activitiesScreenCubit.addActivity(Activity(
                            title: _controllerTitle.text,
                            rubrics: {"professor": _selectedRubrics},
                            isStarted: false,
                            isCompleted: false,
                            isDistributed: false,
                            isFeedbackByProfessor: false,
                          ));
                          Navigator.of(context).pop();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Error adding activities')),
                          );
                        }
                      },
                      child: const Text('Add activity'),
                    ),
                  ),
                ];
                return SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: children,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            }));
  }

  Future<List<Rubric>> fetchDataFromDatabase() async {
    RubricsRepository rubricsRepository = RubricsRepository();
    try {
      return await rubricsRepository.fetchRubrics();
    } catch (e) {
      throw Exception('Error fetching rubrics: $e');
    }
  }

  Future<void> showAlertDialog(BuildContext context, stateRubric) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            alignment: Alignment.center,
            title: const Text('Create New Rubric'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _controllerNewRubric,
                  decoration: const InputDecoration(
                    labelText: 'Enter rubric title',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                    labelText: 'Enter rubric description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                )
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              OutlinedButton(
                onPressed: () {
                  if (_controllerNewRubric.text.trim().isEmpty) return;
                  RubricsRepository rubricsRepository = RubricsRepository();

                  try {
                    rubricsRepository.addRubrics(
                        _controllerNewRubric.text, _controllerDescription.text);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Error creating new rubric')),
                    );
                  }
                  setState(() {
                    _selectedRubrics.add(Rubric(
                        title: _controllerNewRubric.text,
                        description: _controllerDescription.text));

                    _controllerNewRubric.clear();
                    _controllerDescription.clear();
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('Add Rubric'),
              ),
            ],
          );
        });
  }

  calulateInitialValue(List<Rubric> selectedRubrics, List<Rubric> list) {
    List<Rubric> result = [];
    for (var rubric in selectedRubrics) {
      for (var item in list) {
        if (rubric.title == item.title) {
          result.add(item);
        }
      }
    }
    return result;
  }
}
