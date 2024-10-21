import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/firebase_options.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Activity debatePracticeActivity = Activity(
  title: 'Debate Practice',
  rubrics: {
    'pLOzk091UuPrM6hsX1pHLlEQ1LU2': [
      Rubric(
        title: 'Logical Flow',
        description: 'How well the points are connected',
      ),
      Rubric(
        title: 'Persuasiveness',
        description: 'How well the speaker convinces the audience',
      ),
    ]
  },
  isStarted: false,
  isCompleted: false,
  isDistributed: false,
  isFeedbackByProfessor: false,
);

Activity mockInterviewActivity = Activity(
  title: 'Mock Interview Feedback',
  rubrics: {
    'pLOzk091UuPrM6hsX1pHLlEQ1LU2': [
      Rubric(title: 'Body Language', description: "Empty"),
      Rubric(title: 'Eye Contact', description: "Empty"),
    ],
  },
  isStarted: true,
  isCompleted: false,
  isDistributed: true,
  isFeedbackByProfessor: true,
);

Activity teamPresentationActivity = Activity(
  title: 'Team Presentation Feedback',
  rubrics: {
    'pLOzk091UuPrM6hsX1pHLlEQ1LU2': [
      Rubric(title: 'Collaboration', description: "Empty"),
      Rubric(title: 'Task Distribution', description: "Empty"),
    ],
  },
  isStarted: false,
  isCompleted: false,
  isDistributed: false,
  isFeedbackByProfessor: false,
);
Activity publicSpeakingFinalActivity = Activity(
  title: 'Public Speaking Final Assessment',
  rubrics: {
    'pLOzk091UuPrM6hsX1pHLlEQ1LU2': [
      Rubric(title: 'Articulation', description: "Empty"),
      Rubric(title: 'Confidence', description: "Empty"),
    ]
  },
  isStarted: true,
  isCompleted: true,
  isDistributed: true,
  isFeedbackByProfessor: true,
);

List<Activity> activitiesList = [
  debatePracticeActivity,
  mockInterviewActivity,
  teamPresentationActivity,
  publicSpeakingFinalActivity,
];
final Logger log = Logger();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  populateActivities();
  populateRubrics();
  /* deleteActivities();
  deleteActivitiesFromUser(); */
}

void populateRubrics() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var activity in activitiesList) {
    for (var rubric in activity.rubrics.values.first) {
      await firestore
          .collection('act')
          .doc(activity.id)
          .collection('rubrics')
          .add(rubric.toMap());
    }
  }
}

void populateActivities() async {
  for (var activity in activitiesList) {
    await addActivityToFirestore(activity);
    print('${activity.title} uploaded to Firestore');
  }

  print('All activities uploaded successfully!');
}

void deleteActivities() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    firestore.collection('act').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  } catch (e) {
    log.d('Error: $e');
  }
}

//TODO - Dangerous method as anyone can delete activities of others - Need to handle some security aspects
void deleteActivitiesFromUser() {
  try {
    FirebaseFirestore.instance.collection('role_based').get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.update({
          'activities': [],
        });
        log.d('Activities deleted from user');
        log.d(doc.data()['activities']);
      }
    });
  } catch (e) {
    log.d(e.toString());
  }
}

// Function to add an activity to Firestoref
Future<void> addActivityToFirestore(Activity activity) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection('act').add(activity.toMap());
}
