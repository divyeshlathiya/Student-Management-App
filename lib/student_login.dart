import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_management_app/homescreen.dart';

class StudentManagementLogin extends StatefulWidget {
  const StudentManagementLogin({super.key});

  @override
  State<StudentManagementLogin> createState() => _StudentManagementLoginState();
}

class _StudentManagementLoginState extends State<StudentManagementLogin> {
  TextEditingController username = TextEditingController();
  TextEditingController pwd = TextEditingController();

  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    loadCredentials();
  }

  void loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserName = prefs.getString("uname");
    String? savedPwd = prefs.getString("pwd");

    if (savedUserName == "admin" && savedPwd == "1234") {
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHomeScreen(),
          ));
    }
  }

  void saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("uname", username.text);
    await prefs.setString("pwd", pwd.text);
  }

  void login() {
    if (username.text == "admin" && pwd.text == "1234") {
      saveCredentials();

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentHomeScreen(),
          ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login successfully"),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid username or password"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            ClipOval(
              child: Image.asset(
                "assets/Logo.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                hintText: "User name",
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: pwd,
              obscureText: _isVisible,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                hintText: "Your password",
                contentPadding: EdgeInsets.all(16),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text("Login"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
