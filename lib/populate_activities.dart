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
    'professor': [
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
    'professor': [
      Rubric(title: 'Body Language', description: "Empty"),
      Rubric(title: 'Eye Contact', description: "Empty"),
      Rubric(title: 'Confidence', description: "Empty"),
      Rubric(
          title: "**Non-Verbal Communication**",
          description:
              "Effective non-verbal communication involves various aspects of body language and vocal elements:        **Posture :** Maintain a confident, open stance throughout the communication.    **Gestures :** Use purposeful and meaningful hand gestures to emphasize points.    **Eye Contact :** Maintain appropriate eye contact to engage with the audience.    **Facial Expression :** Match your facial expressions with the tone of your message.    **Tone :** Use variation in tone to maintain interest and reflect appropriate emotions.    **Proxemics :** Be aware of personal space and positioning in relation to the audience."),
      Rubric(
          title: "**Audience Engagement Techniques**",
          description:
              "Score based on the use of two audience engagement techniques from the following list:        **Rhetorical Questions:** Pose questions that don’t require an answer but encourage audience reflection.    **Comparison/Analogy/Contrast:** Use comparisons or contrasts to make abstract concepts relatable.    **Use of Figurative Language:** Employ metaphors, similes, or other figurative language for clarity or emphasis.    **Personal Narrative:** Share a personal story to make your message more relatable.    **Call to Action:** Conclude with a clear call for the audience to take specific steps.    **Humor:** Use humor appropriately to build rapport and lighten the mood."),
      Rubric(
          title: "**Verbal Communication**",
          description:
              "Assess verbal delivery based on these criteria:        **Structure and Coherence :** Organize speech in a logical, coherent flow that suits the professional context.    **Clarity of Message :** Ensure the message is clear, simplifying complex or technical terms when necessary."),
      Rubric(
          title: "**Time Management**",
          description:
              "Given the brief nature of the activity, strict time management is essential:        **Respected the time :** Finished within the allotted time.    **Did not respect the time (0 points):** Exceeded the time limit."),
      Rubric(
          title: "**Clarity**",
          description:
              "Focuses on the speaker's ability to deliver a message that is easy to understand:        **Message Precision :** Information is conveyed clearly without ambiguity or unnecessary complexity.    **Language Simplicity :** Uses simple and understandable language, avoiding jargon when addressing a general audience.    **Pronunciation and Articulation :** Words are spoken clearly, and speech is easy to follow."),
      Rubric(
          title: "**Structure**",
          description:
              "Evaluates how well the presentation or speech is organized:        **Introduction :** Begins with a clear and engaging introduction that sets the stage for the message.    **Logical Flow :** Ideas and sections are arranged logically, with smooth transitions between them.    **Conclusion :** Ends with a concise and effective conclusion that reinforces key points."),
      Rubric(
          title: "**Positive Verbal Communication**",
          description:
              "Measures the effectiveness of verbal delivery in terms of engaging the audience and maintaining a positive tone:        **Confidence :** The speaker demonstrates confidence in their voice and delivery.    **Enthusiasm :** Maintains a positive and enthusiastic tone that keeps the audience interested.    **Audience Adaptation :** Tailors language and tone based on the audience’s level of understanding and response.    **Tone and Volume :** Ensures that tone is appropriate for the message, and volume is loud enough to be heard clearly."),
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
    'professor': [
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
    'professor': [
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

  // deleteActivities();
  // deleteActivitiesFromUser();
  // populateActivities();
  // populateRubrics();
}

void populateRubrics() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  for (var activity in activitiesList) {
    for (var rubric in activity.rubrics.values.first) {
      await firestore
          .collection('rubrics')
          .doc(rubric.title)
          .set(rubric.toMap());
    }
  }
}

void populateActivities() async {
  for (var activity in activitiesList) {
    await addActivityToFirestore(activity);
    log.d('${activity.title} uploaded to Firestore');
  }

  log.d('All activities uploaded successfully!');
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
