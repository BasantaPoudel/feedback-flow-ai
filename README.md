# feedback-flow
**FeedbackFlow** allows teachers to create and reuse, multiple-choice questions with images and topics which can be inserted in assessments and quizzes. Its development started as an effort of project IMPRESS to share and reuse questions and quizzes of software engineering.

Students can then answer those questions in sugested quizzes or generated quizzes (pseudo-random) providing them with a useful **self-assessment tool** to improve their learning.

# Technologies
  * [Flutter &gt;= 3.19.2](https://www.postgresql.org/)
  * [Dart &gt;= 3.3.0](https://www.postgresql.org/)
  * [Java 11](https://www.oracle.com/technetwork/java/javase/downloads/jdk11-downloads-5066655.html)
  * [Node 12.14](https://nodejs.org/en/) ([Node Version Manager](https://github.com/nvm-sh/nvm) recommended)
  * [Android Studio](https://www.docker.com/)

**BackEnd**
- Firebase (BaaS)

**FrontEnd**
- Flutter

**Database**
- Firebase Cloudstore

# Installation
* **Install**
* Flutter
  Run flutter doctor -v
  Use fvm to control version or checkout to different version in the flutter repo
  important command to consider - flutter channel stable

flutter pub get

* Android Studio
flutter doctor to verify if everything is setup correctly, the output should be like this:

```
Doctor summary (to see all details, run flutter doctor -v):
[√] Flutter (Channel stable, 3.32.6, on Microsoft Windows [Version 10.0.26100.6899], locale en-GB)
[√] Windows Version (Windows 11 or higher, 24H2, 2009)
[√] Android toolchain - develop for Android devices (Android SDK version 36.0.0)
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps (Visual Studio Community 2022 17.14.9 (July 2025))
[√] Android Studio (version 2025.1.1)
[√] VS Code (version 1.105.1)
[√] Connected device (3 available)
[√] Network resources

• No issues found!
```


## Running the project
flutter run
Go to main.dart and click the Run With Debug button in VSCode


# Snapshots

![Home_Student_ActivityStarted](https://github.com/user-attachments/assets/eac307bc-e0ea-41d0-939c-8ca91a809d59)


# Demonstration 
https://web.tecnico.ulisboa.pt/ist180894/portfolio/Demonstration_FeedbackFlow.mp4

# web-app (only for mobile) 
https://feedbackflow-daf0f.web.app/


