import 'package:flutter/material.dart';

class StudentSettingsScreen extends StatefulWidget {
  final Function(Color) onSetColor;
  final Color prefixColor;
  const StudentSettingsScreen({super.key, required this.onSetColor, required this.prefixColor});

  @override
  State<StudentSettingsScreen> createState() => _StudentSettingsScreenState();
}

class _StudentSettingsScreenState extends State<StudentSettingsScreen> {
  double slider1Val = 0;
  double slider2Val = 0;
  double slider3Val = 0;
  Color? updatedBgColor;

  @override
  void initState() {
    super.initState();
    updatedBgColor = widget.prefixColor;
  }

  void updateColor(double slider1Val, double slider2Val, double slider3Val) {
    setState(() {
      updatedBgColor = Color.fromRGBO(
          slider1Val.toInt(), slider2Val.toInt(), slider3Val.toInt(), 1);
    });
    widget.onSetColor(updatedBgColor!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: updatedBgColor,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set background color",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Slider(
              min: 0,
              max: 255,
              value: slider1Val,
              onChanged: (value) {
                setState(() {
                  slider1Val = value;
                  updatedBgColor = Color.fromRGBO(slider1Val.toInt(),
                      slider2Val.toInt(), slider3Val.toInt(), 1);
                });
              },
            ),
            Slider(
              min: 0,
              max: 255,
              value: slider2Val,
              onChanged: (value) {
                setState(() {
                  slider2Val = value;
                  updatedBgColor = Color.fromRGBO(slider1Val.toInt(),
                      slider2Val.toInt(), slider3Val.toInt(), 1);
                });
              },
            ),
            Slider(
              min: 0,
              max: 255,
              value: slider3Val,
              onChanged: (value) {
                setState(() {
                  slider3Val = value;
                  updatedBgColor = Color.fromRGBO(slider1Val.toInt(),
                      slider2Val.toInt(), slider3Val.toInt(), 1);
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  updateColor(slider1Val, slider2Val, slider3Val);
                  Navigator.pop(context);
                },
                child: Text("Set color")),
          ],
        ),
      ),
    );
  }
}
