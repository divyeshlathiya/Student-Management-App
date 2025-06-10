import 'package:flutter/material.dart';

class StudentAboutScreen extends StatefulWidget {
  const StudentAboutScreen({super.key});

  @override
  State<StudentAboutScreen> createState() => _StudentAboutScreenState();
}

class _StudentAboutScreenState extends State<StudentAboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: Text("About us"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/Logo.png",
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Student Management App",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "About the App:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "This app helps students and administrators manage student data efficiently. "
                "It provides functionalities like adding, editing, and deleting student details "
                "with an interactive user interface.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              Text(
                "Key Features:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              bulletPoint("Add new students with name, age, and course."),
              bulletPoint("Edit or delete student details."),
              bulletPoint("Customize background color from settings."),
              bulletPoint("User-friendly navigation and UI."),
              bulletPoint("Secure login system for students."),
              SizedBox(height: 15),
              Text(
                "Made with ❤️ by Divyesh Lathiya ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
