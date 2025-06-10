import 'package:flutter/material.dart';
import 'package:student_management_app/student.dart';

class StudentDetailsScreen extends StatefulWidget {
  final Student student;
  final Function(Student) onDelete;
  final Function(Student, Student) onEdit;

  const StudentDetailsScreen({
    super.key,
    required this.student,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  bool isEditing = false;
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController courseController;
  late DateTime? birthDate;
  String birthDateMess = "";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    ageController = TextEditingController(text: widget.student.age.toString());
    courseController = TextEditingController(text: widget.student.course);
    birthDate = widget.student.birthDate;
    birthDateMess = birthDate != null
        ? "${birthDate!.toLocal()}".split(' ')[0]
        : "Not Selected";
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    courseController.dispose();
    super.dispose();
  }

  void saveChanges() {
    Student updatedStudent = Student();
    updatedStudent.name = nameController.text;
    updatedStudent.age = int.parse(ageController.text);
    updatedStudent.course = courseController.text;
    updatedStudent.birthDate = birthDate;
    widget.onEdit(widget.student, updatedStudent);
    setState(() {
      isEditing = false;
    });
  }

  Future<void> editBirthDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    if (pickedDate != null) {
      setState(() {
        birthDate = pickedDate;
        birthDateMess = birthDate != null
            ? "${birthDate!.toLocal()}".split(' ')[0]
            : "Not Selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? "Edit Student Details" : "Student Details",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditing
                      ? TextField(
                          controller: nameController,
                          decoration: InputDecoration(labelText: "Name"),
                        )
                      : Text("Name: ${widget.student.name}",
                          style: TextStyle(fontSize: 18)),
                  isEditing
                      ? TextField(
                          controller: ageController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "Age"),
                        )
                      : Text("Age: ${widget.student.age}",
                          style: TextStyle(fontSize: 18)),
                  isEditing
                      ? TextField(
                          controller: courseController,
                          decoration: InputDecoration(labelText: "Course"),
                        )
                      : Text("Course: ${widget.student.course}",
                          style: TextStyle(fontSize: 18)),
                  isEditing
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "Birth date :- $birthDateMess",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  editBirthDate();
                                },
                                child: Icon(Icons.date_range_outlined))
                          ],
                        )
                      : Text("Birth date :- $birthDateMess",
                          style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (isEditing) {
                            saveChanges();
                          } else {
                            setState(() {
                              isEditing = true;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isEditing ? Colors.green : Colors.blue),
                        child: Text(isEditing ? "Save" : "Edit"),
                      ),
                      SizedBox(width: 10),
                      if (isEditing)
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isEditing = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey),
                          child: Text("Cancel"),
                        ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          widget.onDelete(widget.student);
                        },
                        style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: Text("Delete"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
