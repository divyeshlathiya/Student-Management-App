import 'package:flutter/material.dart';
import 'package:student_management_app/student.dart';

class AddStudentScreen extends StatefulWidget {
  final Function(Student) addStudentCallBack;
  const AddStudentScreen({super.key, required this.addStudentCallBack});

  @override
  State<AddStudentScreen> createState() => AddStudentScreenState();
}

class AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController stuName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController course = TextEditingController();
  DateTime? birthDate;
  String birthDatehMess = "";

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Student stu = Student();
      stu.name = stuName.text;
      stu.age = int.tryParse(age.text);
      stu.course = course.text;
      stu.birthDate = birthDate;
      widget.addStudentCallBack(stu);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Student added successfullly"),
          backgroundColor: Colors.green,
        ),
      );
      stuName.clear();
      age.clear();
      course.clear();
      setState(() {
        birthDatehMess = "";
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong :)"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> selectBirthDate() async {
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        initialDate: DateTime.now());
    if (pickedDate != null) {
      setState(() {
        birthDate = pickedDate;
        birthDatehMess = birthDate != null
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
            "Add Students",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: stuName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Student name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plz enter student name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: age,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Student age"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plz enter student age";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: course,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Course"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Plz enter student course";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Birth date :- $birthDatehMess",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                selectBirthDate();
                              },
                              child: Icon(Icons.date_range_outlined))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor:
                                Colors.white // Set button color to blue
                            ),
                        child: Text("Save")),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
