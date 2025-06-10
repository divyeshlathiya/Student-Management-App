import 'dart:async';
import 'package:flutter/material.dart';
import 'package:student_management_app/student_login.dart';

void main() {
  runApp(const StudentManagemantApp());
}

class StudentManagemantApp extends StatefulWidget {
  const StudentManagemantApp({super.key});

  @override
  State<StudentManagemantApp> createState() => _StudentManagemantAppState();
}


class _StudentManagemantAppState extends State<StudentManagemantApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentManagementLogin(),
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StudentManagementSplashScreen extends StatefulWidget {
  const StudentManagementSplashScreen({super.key});

  @override
  State<StudentManagementSplashScreen> createState() =>
      _StudentManagementSplashScreenState();
}

class _StudentManagementSplashScreenState
    extends State<StudentManagementSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StudentManagementLogin(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset(
          "assets/logo.jpg",
          width: 300,
          height: 300,
        ));
  }
}
