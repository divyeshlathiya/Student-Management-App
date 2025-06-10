import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management_app/about_us.dart';
import 'package:student_management_app/add_student.dart';
import 'package:student_management_app/settings.dart';
import 'package:student_management_app/student.dart';
import 'package:student_management_app/student_edit_delete_details.dart';
import 'package:student_management_app/student_login.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int selectedIndex = 0; // 0 -> Home, 1 -> Add Student, 2 -> Student Details
  List<Student> stuList = [];
  Student? selectedStudent;

  Color bgColor = Colors.white;

  void updateColor(Color newBgColor) {
    setState(() {
      bgColor = newBgColor;
    });
  }

  void addStudent(Student student) {
    setState(() {
      stuList.add(student);
    });
  }

  void deleteStudent(Student student) {
    setState(() {
      stuList.remove(student);
      selectedIndex = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${student.name} has been deleted."),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showStudentDetails(Student student) {
    setState(() {
      selectedStudent = student;
      selectedIndex = 2;
    });
  }

  void editStudent(Student oldStudent, Student updatedStudent) {
    setState(() {
      int index = stuList.indexOf(oldStudent);
      if (index != -1) {
        stuList[index] = updatedStudent;
      }
      selectedIndex = 0;
    });
  }

  Widget _buildStudentListScreen() {
    return stuList.isEmpty
        ? Center(
            child: Text(
              "No students added yet!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        : ListView.builder(
            itemCount: stuList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: ListTile(
                  title: Text(stuList[index].name ?? "No Name"),
                  subtitle: Text(
                      "Age: ${stuList[index].age} | Course: ${stuList[index].course}"),
                  leading: CircleAvatar(
                    child: Text(stuList[index].name![0]),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showStudentDetails(stuList[index]);
                  },
                ),
              );
            },
          );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Update selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text("Student Management App"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: Image.asset(
                      "assets/logo.jpg",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome, Student!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              selected: selectedIndex == 0,
              onTap: () {
                onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add Student"),
              selected: selectedIndex == 1,
              onTap: () {
                onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About us"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentAboutScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentSettingsScreen(
                        prefixColor: bgColor,
                        onSetColor: updateColor,
                      ),
                    ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs
                    .clear(); // clear all prefs (username,pwd or any....)
                if (!mounted) return;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentManagementLogin(),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logout successfully !")));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: selectedIndex == 0
            ? _buildStudentListScreen()
            : selectedIndex == 1
                ? AddStudentScreen(addStudentCallBack: addStudent)
                : StudentDetailsScreen(
                    student: selectedStudent!,
                    onDelete: (Student student) {
                      deleteStudent(student);
                    },
                    onEdit: editStudent,
                  ),
      ),
    );
  }
}
